import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/controllers/teacher_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/widgets/create_set.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class SetPage extends StatelessWidget {
  SetPage({
    Key? key,
  }) : super(key: key);

  final TeacherDashboardController teacherDashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            teacherDashboardController.selectedFolder.value!["folderName"]),
      ),
      body: Obx(() {
        return SizedBox(
            width: double.infinity,
            child: teacherDashboardController
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
                      itemCount: teacherDashboardController
                          .selectedFolder.value!["sets"].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> set = teacherDashboardController
                            .selectedFolder.value!["sets"][index];
                        return GestureDetector(
                          onLongPress: () {
                            showConfirmDialogCustom(
                              context,
                              primaryColor: Colors.red,
                              title: "Do you want to delete this Set?",
                              dialogType: DialogType.CONFIRMATION,
                              onAccept: (_) {
                                teacherDashboardController
                                    .selectedSetIndex.value = index;
                                Get.back();
                                teacherDashboardController.deleteSet();
                              },
                            );
                          },
                          onTap: () {
                            TeacherDashboardController
                                teacherDashboardController = Get.find();
                            teacherDashboardController.selectedSetIndex.value =
                                index;
                            Get.toNamed(Routes.TEACHER_QUESTIONS);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.dialog(CreateSet());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
