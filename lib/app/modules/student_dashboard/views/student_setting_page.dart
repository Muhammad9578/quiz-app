import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/controllers/student_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/views/student_scoreboard_view.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/app_widgets.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class StudentSettingPage extends StatelessWidget {
  StudentDashboardController studentDashboardController;
  StudentSettingPage({super.key, required this.studentDashboardController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              30.SpaceX,
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: PrimaryTextField(
                    controller: studentDashboardController.updatename.value,
                    hinttext: "Enter new name"),
                trailing: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (studentDashboardController
                            .updatename.value.text.isEmpty) {
                          toast("Please enter your name");
                        } else {
                          DocumentReference userDocRef = FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid);
                          await userDocRef.update({
                            'name':
                                studentDashboardController.updatename.value.text
                          });

                          studentDashboardController.userData.value!["name"] =
                              studentDashboardController.updatename.value.text;
                          studentDashboardController.userData.refresh();

                          print('Name updated successfully.');
                          toast('Name updated successfully.');
                        }
                      } catch (error) {
                        print('Error updating Name: $error');
                        toast('Something Went Wrong.');
                      }
                    },
                    child: const Text("Update")),
              ),
              15.SpaceX,
              ListTile(
                onTap: () async {
                  Get.to(const ScoreboardPage());
                },
                title: const Text("ScoreBoard"),
                leading: const Icon(
                  Icons.school_rounded,
                  color: Colors.black,
                ),
              ),
              15.SpaceX,
              ListTile(
                onTap: () async {
                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.sendPasswordResetEmail(
                        email: auth.currentUser!.email!);
                    print(
                        'Password reset email sent to ${auth.currentUser!.email!}');
                    toast(
                        'Password reset email sent to ${auth.currentUser!.email!}');
                  } catch (error) {
                    print('Failed to send password reset email: $error');
                    toast('Failed to send password reset email: $error');
                  }
                },
                title: const Text("Change Password"),
                leading: const Icon(
                  Icons.password,
                  color: Colors.black,
                ),
              ),
              15.SpaceX,
              ListTile(
                onTap: () {
                  showConfirmDialogCustom(
                    context,
                    primaryColor: Colors.red,
                    title: "Do you want to logout from the app?",
                    dialogType: DialogType.CONFIRMATION,
                    onAccept: (_) async {
                      await GoogleSignIn().signOut();
                      FirebaseAuth.instance.signOut().then((value) {
                        toast("User logout Succesfully");
                        Get.offAllNamed(Routes.INTRODUCTION);
                      });
                    },
                  );
                },
                title: const Text("Logout"),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }
}
