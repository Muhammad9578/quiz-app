import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/controllers/student_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class StudentSetPage extends StatelessWidget {
  StudentSetPage({
    Key? key,
  }) : super(key: key);

  final StudentDashboardController studentDashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            studentDashboardController.selectedFolder.value!["folderName"]),
      ),
      body: Obx(() {
        return SizedBox(
            width: double.infinity,
            child: studentDashboardController
                        .selectedFolder.value!["sets"].length ==
                    0
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text("No Sets Found")],
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: studentDashboardController
                          .selectedFolder.value!["sets"].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> set = studentDashboardController
                            .selectedFolder.value!["sets"][index];
                        return GestureDetector(
                          onTap: () {
                            if (studentDashboardController.selectedFolder
                                    .value!["sets"][index]["questions"].length <
                                3) {
                              toast("This Set is not available for Quiz");
                            } else {
                              // StudentDashboardController
                              //     studentDashboardController = Get.find();
                              studentDashboardController
                                  .selectedSetIndex.value = index;
                              studentDashboardController.wronganswers.value = 0;
                              studentDashboardController.questions.value =
                                  studentDashboardController
                                          .selectedFolder.value!["sets"][
                                      studentDashboardController
                                          .selectedSetIndex.value]['questions'];
                              studentDashboardController.questions.value
                                  .shuffle(Random());
                              Get.toNamed(Routes.STUDENT_QUESTIONS);
                            }
                          },
                          child: Card(
                            shadowColor: ColorHelper.primarycolor,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.doc_fill,
                                    size: 70,
                                    color: ColorHelper.primarycolor,
                                  ),
                                  10.SpaceX,
                                  Text(set["setName"]),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ));
      }),
    );
  }
}
