import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/routes/app_pages.dart';
import 'package:quiz_app_flutter/app/utils/app_widgets.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';
import 'package:quiz_app_flutter/app/utils/images.dart';
import 'package:quiz_app_flutter/app/utils/strings.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorHelper.whitecolor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                40.SpaceX,
                SizedBox(
                    height: Get.height * .25,
                    child: Image.asset(AppImages.loginimage)),
                Align(
                  alignment: Alignment.topLeft,
                  child: text(lbl_login,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      textColor: ColorHelper.blackcolor),
                ),
                40.SpaceX,
                PrimaryTextField(
                  controller: controller.emailid,
                  hinttext: 'Email ID',
                  prefixIcon: Icons.email,
                  focusnode: controller.emailNode,
                  onsubmit: (_) {
                    controller.passwordNode.requestFocus();
                  },
                ),
                20.SpaceX,
                PrimaryTextField(
                  controller: controller.password,
                  hinttext: 'Password',
                  focusnode: controller.passwordNode,
                  prefixIcon: Icons.password,
                  isobscure: true,
                  onsubmit: (_) {
                    hideKeyboard(context);
                  },
                ),
                15.SpaceX,
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {},
                    child: text(lbl_forgetpassword,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        textColor: ColorHelper.blackcolor),
                  ),
                ),
                40.SpaceX,
                PrimaryButton(ontap: controller.loginUser, label: 'Login'),
                20.SpaceX,
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "New to app? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                          TextSpan(
                              text: "Register",
                              style: TextStyle(color: ColorHelper.primarycolor))
                        ])),
                  ),
                ),
                20.SpaceX,
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      thickness: 1.5,
                    )),
                    5.SpaceY,
                    const Text("OR"),
                    5.SpaceY,
                    const Expanded(
                        child: Divider(
                      thickness: 1.5,
                    ))
                  ],
                ),
                5.SpaceX,
                IconButton(
                  onPressed: () {
                    controller.signInWithGoogle();
                  },
                  icon: const Icon(
                    Bootstrap.google,
                    color: Colors.red,
                  ),
                ),
                40.SpaceX,
              ],
            ),
          ),
        ));
  }
}
