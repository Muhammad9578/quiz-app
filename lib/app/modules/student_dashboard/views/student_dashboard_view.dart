import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/controllers/student_dashboard_controller.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';

class StudentDashboardView extends GetView<StudentDashboardController> {
  const StudentDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
  }
}
