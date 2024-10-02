import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/controllers/teacher_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/widgets/create_question.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({
    Key? key,
  }) : super(key: key);

  final TeacherDashboardController teacherDashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teacherDashboardController.selectedFolder.value!["sets"]
            [teacherDashboardController.selectedSetIndex.value]['setName']),
      ),
      body: Obx(() {
        return SizedBox(
          width: double.infinity,
          child: teacherDashboardController
                      .selectedFolder
                      .value!["sets"]
                          [teacherDashboardController.selectedSetIndex.value]
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
                  child: ListView.builder(
                    itemCount: teacherDashboardController
                        .selectedFolder
                        .value!["sets"]
                            [teacherDashboardController.selectedSetIndex.value]
                            ['questions']
                        .length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> question = teacherDashboardController
                                  .selectedFolder.value!["sets"][
                              teacherDashboardController.selectedSetIndex.value]
                          ['questions'][index];
                      return InkWell(
                        onLongPress: () {
                          teacherDashboardController
                              .selectedQuestionIndex.value = index;
                          showConfirmDialogCustom(
                            context,
                            primaryColor: Colors.red,
                            title: "Do you want to delete this Question?",
                            dialogType: DialogType.CONFIRMATION,
                            onAccept: (_) {
                              Get.back();
                              teacherDashboardController.deleteQuestion();
                            },
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shadowColor: ColorHelper.primarycolor,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Question:"),
                                Text(question["question"]),
                                10.SpaceX,
                                const Text("Option:"),
                                Text(question["option"]),
                                5.SpaceX,
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("1. ${question["options"][0]}"),
                                //     Text("2. ${question["options"][1]}")
                                //   ],
                                // ),
                                // 5.SpaceX,
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("3. ${question["options"][2]}"),
                                //     Text("4. ${question["options"][3]}")
                                //   ],
                                // ),
                                // 5.SpaceX,
                                // Center(
                                //   child: Text(
                                //       "Correct Answer: ${question["options"][question["correctoption"]]}"),
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (teacherDashboardController
                  .selectedFolder
                  .value!["sets"]
                      [teacherDashboardController.selectedSetIndex.value]
                      ['questions']
                  .length >=
              3) {
            teacherDashboardController.questionOptionFocusNode.value = [
              FocusNode(),
              FocusNode()
            ];
            teacherDashboardController.questionOptionControllers.value = [
              TextEditingController(),
              TextEditingController()
            ];
            // teacherDashboardController.questionOptionWidgets.value = [
            //   PrimaryTextField(
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[0],
            //     controller:
            //         teacherDashboardController.questionOptionControllers[0],
            //     hinttext: 'Enter question',
            //     prefixIcon: Icons.title,
            //     onsubmit: (v) {
            //       teacherDashboardController.questionOptionFocusNode[1]
            //           .requestFocus();
            //     },
            //   ),
            //   PrimaryTextField(
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[1],
            //     controller:
            //         teacherDashboardController.questionOptionControllers[1],
            //     hinttext: 'Enter option',
            //     prefixIcon: CupertinoIcons.dot_square,
            //   ),
            // ];
          } else {
            teacherDashboardController.questionOptionFocusNode =
                <FocusNode>[].obs;
            // teacherDashboardController.questionOptionWidgets = <Widget>[].obs;
            teacherDashboardController.questionOptionControllers =
                <TextEditingController>[].obs;
            teacherDashboardController.questionOptionFocusNode.addAll([
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode()
            ]);
            teacherDashboardController.questionOptionControllers.addAll([
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController()
            ]);
            // teacherDashboardController.questionOptionWidgets.value.addAll([
            //   PrimaryTextField(
            //     controller:
            //         teacherDashboardController.questionOptionControllers[0],
            //     hinttext: 'Enter question',
            //     prefixIcon: Icons.title,
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[0],
            //     onsubmit: (v) {
            //       teacherDashboardController.questionOptionFocusNode[1]
            //           .requestFocus();
            //     },
            //   ),
            //   PrimaryTextField(
            //     controller:
            //         teacherDashboardController.questionOptionControllers[1],
            //     hinttext: 'Enter option',
            //     prefixIcon: CupertinoIcons.dot_square,
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[1],
            //     onsubmit: (v) {
            //       teacherDashboardController.questionOptionFocusNode[2]
            //           .requestFocus();
            //     },
            //   ),
            //   PrimaryTextField(
            //     controller:
            //         teacherDashboardController.questionOptionControllers[2],
            //     hinttext: 'Enter question',
            //     prefixIcon: Icons.title,
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[2],
            //     onsubmit: (v) {
            //       teacherDashboardController.questionOptionFocusNode[3]
            //           .requestFocus();
            //     },
            //   ),
            //   PrimaryTextField(
            //     controller:
            //         teacherDashboardController.questionOptionControllers[3],
            //     hinttext: 'Enter option',
            //     prefixIcon: CupertinoIcons.dot_square,
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[3],
            //     onsubmit: (v) {
            //       teacherDashboardController.questionOptionFocusNode[4]
            //           .requestFocus();
            //     },
            //   ),
            //   PrimaryTextField(
            //     controller:
            //         teacherDashboardController.questionOptionControllers[4],
            //     hinttext: 'Enter question',
            //     prefixIcon: Icons.title,
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[4],
            //     onsubmit: (v) {
            //       teacherDashboardController.questionOptionFocusNode[5]
            //           .requestFocus();
            //     },
            //   ),
            //   PrimaryTextField(
            //     controller:
            //         teacherDashboardController.questionOptionControllers[5],
            //     hinttext: 'Enter option',
            //     prefixIcon: CupertinoIcons.dot_square,
            //     focusnode:
            //         teacherDashboardController.questionOptionFocusNode[5],
            //   )
            // ]);
          }
          teacherDashboardController.questionOptionFocusNode[0].requestFocus();
          Get.dialog(AddQuestion());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
