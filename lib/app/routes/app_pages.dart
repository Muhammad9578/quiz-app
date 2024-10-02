import 'package:get/get.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/views/student_home_page.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/views/student_questions_page.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/views/student_set_page.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/views/folder_page.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/views/questions_page.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/views/set_page.dart';

import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/student_dashboard/bindings/student_dashboard_binding.dart';
import '../modules/student_dashboard/views/student_dashboard_view.dart';
import '../modules/teacher_dashboard/bindings/teacher_dashboard_binding.dart';
import '../modules/teacher_dashboard/views/teacher_dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INTRODUCTION;

  static final routes = [
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_DASHBOARD,
      page: () => const TeacherDashboardView(),
      binding: TeacherDashboardBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_DASHBOARD,
      page: () => const StudentDashboardView(),
      binding: StudentDashboardBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_FOLDERS,
      page: () => const FolderPage(),
      binding: TeacherDashboardBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_QUESTIONS,
      page: () => QuestionPage(),
      binding: TeacherDashboardBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_SETS,
      page: () => SetPage(),
      binding: TeacherDashboardBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_SETS,
      page: () => StudentSetPage(),
      binding: StudentDashboardBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_QUESTIONS,
      page: () => StudentQuestionPage(),
      binding: StudentDashboardBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_HOME,
      page: () => StudentHomePage(),
      binding: StudentDashboardBinding(),
    ),
  ];
}
