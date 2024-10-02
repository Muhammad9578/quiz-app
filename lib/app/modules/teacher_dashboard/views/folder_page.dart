import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/controllers/teacher_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/views/setting_page.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/widgets/create_folder.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class FolderPage extends StatelessWidget {
  const FolderPage({super.key});
  // final TeacherDashboardController teacherDashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          centerTitle: true,
          title: const Text("Dashboard"),
          actions: [
            IconButton(
                onPressed: () {
                  TeacherDashboardController teacherDashboardController =
                      Get.find();
                  Get.to(SettingPage(
                    teacherDashboardController: teacherDashboardController,
                  ));
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('folders')
                .where('createdby',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                // .orderBy('creationdate', descending: false)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: ColorHelper.primarycolor,
                ));
              }
              if (snapshot.hasError) {
                return const Center(child: Text('SomeThing Went Wrong'));
              }
              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No folders available'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot folder = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      TeacherDashboardController teacherDashboardController =
                          Get.find();
                      teacherDashboardController.selectedFolder.value = folder;

                      Get.toNamed(Routes.TEACHER_SETS);
                      // Get.toNamed(Routes.TEACHER_QUESTIONS);
                    },
                    onLongPress: () {
                      showConfirmDialogCustom(
                        context,
                        primaryColor: Colors.red,
                        title: "Do you want to delete this folder?",
                        dialogType: DialogType.CONFIRMATION,
                        onAccept: (_) {
                          FirebaseFirestore.instance
                              .collection('folders')
                              .doc(folder.id)
                              .delete()
                              .then((value) {
                            toast("Folder deleted successfully");
                          }).catchError((error) {
                            // Handle error or display a message
                            print("Failed to delete folder: $error");
                            toast("Failed to delete folder");
                          });
                        },
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      shadowColor: ColorHelper.primarycolor,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.folder,
                              size: 70,
                              color: ColorHelper.primarycolor,
                            ),
                            10.SpaceX,
                            Text(folder['folderName']),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Get.dialog(CreateFolder());
          },
          child: const Icon(Icons.add),
        ));
  }
}
