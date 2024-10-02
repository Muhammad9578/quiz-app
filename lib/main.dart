import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialize();
  MaterialColor primarySwatch =
      ColorHelper.createPrimarySwatch(ColorHelper.primarycolor);
  runApp(GetMaterialApp(
      color: ColorHelper.primarycolor,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: false,
          primarySwatch: primarySwatch,
          fontFamily: GoogleFonts.poppins().fontFamily),
      title: "Quizly",
      initialRoute: AppPages.INITIAL,
      navigatorKey: navigatorKey,
      getPages: AppPages.routes));
}
