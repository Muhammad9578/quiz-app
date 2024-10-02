import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/controllers/teacher_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/utils/app_widgets.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';
import 'package:quiz_app_flutter/app/utils/strings.dart';

class AddQuestion extends StatelessWidget {
  AddQuestion({super.key});
  final TeacherDashboardController teacherDashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    double v = 0.0;
    return Material(
      child: Container(
        height: Get.height,
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            children: [
              20.SpaceX,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(lbl_addquestion,
                      textColor: Colors.black, fontWeight: FontWeight.w600),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            int qindex = teacherDashboardController
                                .questionOptionControllers.length;
                            int oindex = teacherDashboardController
                                    .questionOptionControllers.length +
                                1;
                            teacherDashboardController.questionOptionControllers
                                .addAll([
                              TextEditingController(),
                              TextEditingController()
                            ]);

                            teacherDashboardController.questionOptionFocusNode
                                .addAll([FocusNode(), FocusNode()]);
                            teacherDashboardController.questionOptionControllers
                                .refresh();
                            teacherDashboardController.questionOptionControllers
                                .refresh();

                            teacherDashboardController
                                .questionOptionFocusNode[oindex]
                                .requestFocus();

                            Future.delayed(const Duration(seconds: 1), () {
                              teacherDashboardController.scrollController
                                  .animateTo(
                                teacherDashboardController
                                    .scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 50),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: const CircleAvatar(
                            backgroundColor: ColorHelper.primarycolor,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )),
                      5.SpaceY,

                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ColorHelper.primarycolor),
                          ),
                          onPressed: teacherDashboardController.addQuestion,
                          child: text(
                            "Done",
                              fontSize: 16.0,
                              textColor: ColorHelper.whitecolor,
                              fontWeight: FontWeight.bold)),
                      5.SpaceY,
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const CircleAvatar(
                          backgroundColor: ColorHelper.primarycolor,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      )

                      // SizedBox(
                      //     width: Get.width * .3,
                      //     child: PrimaryButton(
                      //         ontap: () {
                      //           Get.back();
                      //         },
                      //         label: "Cancel")),
                    ],
                  ),
                ],
              ),
              20.SpaceX,
              Expanded(
                child: ListView.builder(
                  itemCount: teacherDashboardController
                      .questionOptionControllers.length,
                  controller: teacherDashboardController.scrollController,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 60,
                      child: Focus(
                        onFocusChange: (bool hasFocus) {
                          if (hasFocus) {
                            print("index$index  ");
                            if (index % 2 != 0 && index != 0) {
                              teacherDashboardController.scrollController
                                  .animateTo(
                                (index) * 60.toDouble(),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        },
                        child: PrimaryTextField(
                          onsubmit: (v) {
                            if (index <
                                teacherDashboardController
                                        .questionOptionFocusNode.length -
                                    1) {
                              FocusScope.of(context).requestFocus(
                                  teacherDashboardController
                                      .questionOptionFocusNode[index + 1]);
                            }
                          },
                          focusnode: teacherDashboardController
                              .questionOptionFocusNode[index],
                          controller: teacherDashboardController
                              .questionOptionControllers[index],
                          hinttext: index % 2 == 0
                              ? 'Enter Question'
                              : 'Enter option ',
                          prefixIcon: index % 2 == 0
                              ? Icons.title
                              : CupertinoIcons.dot_square,
                        ),
                      ),
                    );
                  },
                ),
              ),
              (MediaQuery.of(context).viewInsets.bottom + 0).SpaceX,
              MediaQuery.of(context).viewInsets.bottom != 0.0
                  ? const SizedBox.shrink()
                  : const SizedBox.shrink()
            ],
          );
        }),
      ),
    );
  }
}
