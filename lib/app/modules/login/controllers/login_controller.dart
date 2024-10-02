import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/introduction/controllers/introduction_controller.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/helpers.dart';
import 'package:quiz_app_flutter/app/utils/images.dart';

class LoginController extends GetxController {
  IntroductionController introductionController =
      Get.put(IntroductionController());
  final Rx<Map<String, dynamic>?> userData =
      Rx<Map<String, dynamic>?>(<String, dynamic>{});
  final precacheImage = const AssetImage(AppImages.loginimage);

  final TextEditingController emailid = TextEditingController();
  final TextEditingController password = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  Future<void> loginUser() async {
    if (validateFields()) {
      try {
        if (!Get.isDialogOpen!) {
          Get.dialog(
              Loader(
                size: 50,
              ).visible(true),
              barrierDismissible: false);
        }
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailid.text,
          password: password.text,
        );

        User? user = userCredential.user;

        if (user != null) {
          DocumentReference userRef =
              FirebaseFirestore.instance.collection('users').doc(user.uid);
          DocumentSnapshot userSnap = await userRef.get();
          if (userSnap.exists) {
            if (Get.isDialogOpen!) {
              Get.back();
            }
            toast('Login successful');

            userData.value = userSnap.data() as Map<String, dynamic>?;
            print('User data retrieved: ${userData.value}');
            if (userData.value!["usertype"] == 1) {
              Get.offAllNamed(Routes.TEACHER_FOLDERS);
            } else {
              Get.offAllNamed(Routes.STUDENT_HOME);
            }
          } else {
            print('User data does not exist.');
          }
        } else {
          toast('Something went wrong please try again');
          await FirebaseAuth.instance.signOut();
        }
        if (Get.isDialogOpen!) {
          Get.back();
        }
      } on FirebaseAuthException catch (e) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        print(e.code);
        if (e.code == "invalid-credential") {
          toast("Please check your email and password, and try again");
        } else if (e.code == "invalid-email") {
          toast("Email address is badly formatted.");
        } else {
          toast("Something went wrong. Please try again");
        }
      } catch (e) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        print("Error during login: $e");
        toast(e.toString());
      }
    }
  }

  Future signInWithGoogle() async {
    try {
      if (!Get.isDialogOpen!) {
        Get.dialog(
            Loader(
              size: 50,
            ).visible(true),
            barrierDismissible: false);
      }
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName,
        'usertype': introductionController.seleteduser.value
      });
      if (introductionController.seleteduser.value == 1) {
        Get.offAllNamed(Routes.TEACHER_FOLDERS);
      } else {
        Get.offAllNamed(Routes.STUDENT_HOME);
      }
      if (Get.isDialogOpen!) {
        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      if (e.code == 'account-exists-with-different-credential') {
        toast(e.message);
      } else if (e.code == 'invalid-credential') {
        toast(e.message);
      }
    } catch (e) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      print(e.toString());
      toast("Something went wrong");
    }
  }

  validateFields() {
    if (emailid.text.isEmpty) {
      toast("Please enter your email");
      return false;
    } else if (password.text.isEmpty) {
      toast("Please enter your password");
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    preloadImage(navigatorKey.currentContext!, precacheImage);
  }

  @override
  void onReady() {
    super.onReady();
    preloadImage(navigatorKey.currentContext!, precacheImage);
  }
}
