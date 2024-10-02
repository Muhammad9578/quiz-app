import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';

import '../controllers/teacher_dashboard_controller.dart';

class TeacherDashboardView extends GetView<TeacherDashboardController> {
  const TeacherDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: controller.pages[controller.selectedTab.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedTab.value,
          onTap: (index) => controller.changeTab(index),
          selectedItemColor: ColorHelper.primarycolor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      );
    });
  }
}
