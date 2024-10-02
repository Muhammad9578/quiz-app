import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/controllers/teacher_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/utils/app_widgets.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';
import 'package:quiz_app_flutter/app/utils/strings.dart';

class CreateFolder extends StatelessWidget {
  CreateFolder({super.key});
  final TeacherDashboardController teacherDashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Get.height * .4,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(lbl_createfolder,
                textColor: Colors.black, fontWeight: FontWeight.w600),
            30.SpaceX,
            PrimaryTextField(
              controller: teacherDashboardController.title,
              hinttext: 'Enter Title',
              prefixIcon: Icons.title,
            ),
            // 10.SpaceX,
            // PrimaryTextField(
            //   controller: teacherDashboardController.subtitle,
            //   hinttext: 'Enter Subtitle',
            //   prefixIcon: Icons.subtitles_outlined,
            // ),
            20.SpaceX,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: Get.width * .3,
                    child: PrimaryButton(
                        ontap: () {
                          Get.back();
                        },
                        label: "Cancel")),
                20.SpaceY,
                SizedBox(
                    width: Get.width * .3,
                    child: PrimaryButton(
                        ontap: teacherDashboardController.createFolder,
                        label: "Create"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
