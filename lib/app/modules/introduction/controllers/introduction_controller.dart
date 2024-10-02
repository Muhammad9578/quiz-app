import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';

class IntroductionController extends GetxController {
  var userData;
  RxInt seleteduser = 0.obs;

  Future<void> checkUserLoginStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      try {
        if (!Get.isDialogOpen!) {
          Get.dialog(
              Loader(
                size: 50,
              ).visible(true),
              barrierDismissible: false);
        }
        print('User is logged in');
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        DocumentSnapshot userSnap = await userRef.get();

        if (Get.isDialogOpen!) {
          Get.back();
        }
        if (userSnap.exists) {
          print('User data retrieved: ${userSnap.data()}');
          userData = userSnap.data();
          if (userData["usertype"] == 1) {
            Get.offAllNamed(Routes.TEACHER_FOLDERS);
          } else {
            Get.offAllNamed(Routes.STUDENT_HOME);
          }
        } else {
          print('User data does not exist.');
        }
      } catch (e) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
      }
    } else {
      print('User is not logged in');
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkUserLoginStatus();
  }
}
