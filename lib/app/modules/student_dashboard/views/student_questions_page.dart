import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/controllers/student_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class StudentQuestionPage extends StatelessWidget {
  StudentQuestionPage({
    Key? key,
  }) : super(key: key);

  final StudentDashboardController studentDashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studentDashboardController.selectedFolder.value!["sets"]
            [studentDashboardController.selectedSetIndex.value]['setName']),
      ),
      body: Obx(() {
        return SizedBox(
          width: double.infinity,
          child: studentDashboardController
                      .selectedFolder
                      .value!["sets"]
                          [studentDashboardController.selectedSetIndex.value]
                          ['questions']
                      .length ==
                  0
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text("No Questions Found")],
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PageView.builder(
                    controller: studentDashboardController.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: studentDashboardController.questions.length,
                    itemBuilder: (context, index) {
                      int length = studentDashboardController.questions.length;
                      List<dynamic> allOptions = [];

                      Map<String, dynamic> question =
                          studentDashboardController.questions[index];
                      for (var data in studentDashboardController.questions) {
                        if (question["option"] != data["option"]) {
                          allOptions.add(data["option"]);
                        }
                      }
                      List<dynamic> options = [
                        question["option"],
                        allOptions[0],
                        allOptions[1]
                      ];
                      options.shuffle();

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            20.SpaceX,
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: ColorHelper.primarycolor,
                                  shape: BoxShape.circle),
                              child: Text(
                                "${index + 1}/$length",
                                style: const TextStyle(
                                    color: ColorHelper.whitecolor),
                              ),
                            ),
                            20.SpaceX,
                            Card(
                              elevation: 5,
                              shadowColor: ColorHelper.primarycolor,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Question: ${index + 1}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      question["question"],
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    20.SpaceX,
                                    const Text(
                                      "Select Correct Answer:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Obx(() {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text("${options[0]}"),
                                            leading: Radio<int>(
                                              value: 0,
                                              groupValue:
                                                  studentDashboardController
                                                      .selectedOption.value,
                                              onChanged: (int? value) {
                                                studentDashboardController
                                                    .selectedOption
                                                    .value = value!;
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: Text("${options[1]}"),
                                            leading: Radio<int>(
                                              value: 1,
                                              groupValue:
                                                  studentDashboardController
                                                      .selectedOption.value,
                                              onChanged: (int? value) {
                                                studentDashboardController
                                                    .selectedOption
                                                    .value = value!;
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: Text("${options[2]}"),
                                            leading: Radio<int>(
                                              value: 2,
                                              groupValue:
                                                  studentDashboardController
                                                      .selectedOption.value,
                                              onChanged: (int? value) {
                                                studentDashboardController
                                                    .selectedOption
                                                    .value = value!;
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    25.SpaceX,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              if (studentDashboardController
                                                      .selectedOption.value ==
                                                  4) {
                                                toast(
                                                    "Please select option first");
                                                return;
                                              }
                                              if (index + 1 == length) {
                                                if (question["option"] ==
                                                    options[
                                                        studentDashboardController
                                                            .selectedOption
                                                            .value]) {
                                                  studentDashboardController
                                                      .showcorrectAnswerDialog(
                                                          question, false);
                                                  studentDashboardController
                                                      .selectedOption.value = 4;
                                                } else {
                                                  studentDashboardController
                                                      .wronganswers.value++;
                                                  studentDashboardController
                                                      .showwrongAnswerDialog(
                                                          question,
                                                          false,
                                                          options[
                                                              studentDashboardController
                                                                  .selectedOption
                                                                  .value]);
                                                  studentDashboardController
                                                      .selectedOption.value = 4;
                                                }
                                              } else {
                                                if (question["option"] ==
                                                    options[
                                                        studentDashboardController
                                                            .selectedOption
                                                            .value]) {
                                                  studentDashboardController
                                                      .showcorrectAnswerDialog(
                                                          question, true);
                                                  studentDashboardController
                                                      .selectedOption.value = 4;
                                                } else {
                                                  studentDashboardController
                                                      .wronganswers.value++;
                                                  studentDashboardController
                                                      .showwrongAnswerDialog(
                                                          question,
                                                          true,
                                                          options[
                                                              studentDashboardController
                                                                  .selectedOption
                                                                  .value]);
                                                  studentDashboardController
                                                      .selectedOption.value = 4;
                                                }
                                              }
                                            },
                                            child: Text(index + 1 == length
                                                ? "Finish"
                                                : "Next"))
                                      ],
                                    ),
                                    20.SpaceX,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        );
      }),
    );
  }
}
