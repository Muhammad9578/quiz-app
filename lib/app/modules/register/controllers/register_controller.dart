import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/introduction/controllers/introduction_controller.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/helpers.dart';

class RegisterController extends GetxController {
  IntroductionController introductionController =
      Get.put(IntroductionController());
//varibles
  RxBool isloading = false.obs;
  final TextEditingController fullname = TextEditingController();
  final TextEditingController emailid = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();

  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode cpasswordNode = FocusNode();

  Future<void> signUp() async {
    if (validateFields()) {
      try {
        if (!Get.isDialogOpen!) {
          Get.dialog(
              Loader(
                size: 50,
              ).visible(true),
              barrierDismissible: false);
        }
        isloading.value = true;
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailid.text,
          password: password.text,
        );
        User? user = userCredential.user;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'email': emailid.text,
            'name': fullname.text,
            'usertype': introductionController.seleteduser.value
          });
          toast("Registered succesfully.");

          isloading.value = false;
          if (introductionController.seleteduser.value == 1) {
            Get.offAllNamed(Routes.TEACHER_FOLDERS);
          } else {
            Get.offAllNamed(Routes.STUDENT_HOME);
          }
          if (Get.isDialogOpen!) {
            Get.back();
          }
        }
      } on FirebaseAuthException catch (e) {
        isloading.value = false;
        if (Get.isDialogOpen!) {
          Get.back();
        }
        toast(e.message.toString());
      } catch (e) {
        isloading.value = false;
        if (Get.isDialogOpen!) {
          Get.back();
        }
        print("Error during sign-up: $e");
        toast(e.toString());
      }
    }
  }

  bool validateFields() {
    if (fullname.text.isEmpty) {
      toast("Please enter your name");
      return false;
    } else if (emailid.text.isEmpty) {
      toast("Please enter your email");
      return false;
    } else if (!isValidEmail(emailid.text)) {
      toast(
          "Please enter correct email address, your email is badly formatted");
      return false;
    } else if (password.text.length < 6) {
      toast("Password must contain 6 characters");
      return false;
    } else if (password.text.isEmpty) {
      toast("Please enter your password");
      return false;
    } else if (password.text != cpassword.text) {
      toast("Password and confirm password dosen't match");
      return false;
    }
    return true;
  }
}
