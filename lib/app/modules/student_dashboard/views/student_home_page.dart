import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/controllers/student_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/views/student_setting_page.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

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
                StudentDashboardController studentDashboardController =
                    Get.find();
                Get.to(StudentSettingPage(
                  studentDashboardController: studentDashboardController,
                ));
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('folders').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: ColorHelper.primarycolor,
              ));
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something Went Wrong'));
            }
            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No folders available'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot folder = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    if (folder['sets'].length == 0) {
                      toast("This Folder has no sets");
                    } else {
                      StudentDashboardController studentDashboardController =
                          Get.find();
                      studentDashboardController.selectedFolder.value = folder;

                      Get.toNamed(Routes.STUDENT_SETS);
                    }
                  },
                  child: Card(
                    shadowColor: ColorHelper.primarycolor,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            CupertinoIcons.folder,
                            size: 60,
                            color: ColorHelper.primarycolor,
                          ),
                          20.SpaceY,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    folder['folderName'],
                                    style: const TextStyle(
                                        color: ColorHelper.primarycolor,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              5.SpaceX,
                              Row(
                                children: [
                                  Text(
                                    folder['teacherName'],
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          )
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
    );
  }
}
