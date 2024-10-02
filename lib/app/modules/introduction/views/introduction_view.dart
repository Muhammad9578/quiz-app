import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/app_widgets.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';
import 'package:quiz_app_flutter/app/utils/images.dart';
import 'package:quiz_app_flutter/app/utils/strings.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  IntroductionView({Key? key}) : super(key: key);
  final IntroductionController introductionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorHelper.whitecolor,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.SpaceX,
                SizedBox(
                    height: Get.height * .2,
                    child: Image.asset(AppImages.loginimage)),
                // text(lbl_welcome,
                //     fontSize: 32.0,
                //     fontWeight: FontWeight.bold,
                //     textColor: ColorHelper.blackcolor),
                100.SpaceX,
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: text(lbl_selecttype,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        textColor: ColorHelper.blackcolor),
                  ),
                ),
                SizedBox(
                  height: Get.width * .5,
                  child: Obx(() {
                    return Row(
                      children: [
                        SelectUser(
                          label: 'Student',
                          image: AppImages.studentimage,
                          selectedcolor:
                              introductionController.seleteduser.value == 0
                                  ? ColorHelper.primarycolor
                                  : Colors.grey,
                          ontap: () {
                            if (introductionController.seleteduser.value != 0) {
                              introductionController.seleteduser.value = 0;
                            }
                          },
                        ),
                        SelectUser(
                          label: 'Teacher',
                          image: AppImages.teacherimage,
                          selectedcolor:
                              introductionController.seleteduser.value == 1
                                  ? ColorHelper.primarycolor
                                  : Colors.grey,
                          ontap: () {
                            if (introductionController.seleteduser.value != 1) {
                              introductionController.seleteduser.value = 1;
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ),
                const Spacer(),
                PrimaryButton(
                  label: lbl_letsbegin,
                  ontap: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                ),
                100.SpaceX,
              ],
            ),
          ),
        ));
  }
}
