import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/utils/app_widgets.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';
import 'package:quiz_app_flutter/app/utils/images.dart';
import 'package:quiz_app_flutter/app/utils/strings.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
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
                    height: Get.height * .2,
                    child: Image.asset(AppImages.loginimage)),
                Align(
                  alignment: Alignment.topLeft,
                  child: text(lbl_register,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      textColor: ColorHelper.blackcolor),
                ),
                40.SpaceX,
                PrimaryTextField(
                  controller: controller.fullname,
                  hinttext: 'Full Name',
                  prefixIcon: Icons.person,
                  focusnode: controller.nameNode,
                  onsubmit: (_) {
                    controller.emailNode.requestFocus();
                  },
                ),
                20.SpaceX,
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
                  prefixIcon: Icons.password,
                  isobscure: true,
                  focusnode: controller.passwordNode,
                  onsubmit: (_) {
                    controller.cpasswordNode.requestFocus();
                  },
                ),
                20.SpaceX,
                PrimaryTextField(
                  controller: controller.cpassword,
                  hinttext: 'Confirm Password',
                  prefixIcon: Icons.password,
                  focusnode: controller.cpasswordNode,
                  isobscure: true,
                  onsubmit: (_) {
                    hideKeyboard(context);
                  },
                ),
                40.SpaceX,
                PrimaryButton(ontap: controller.signUp, label: 'Register'),
                20.SpaceX,
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Already Registered? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                          TextSpan(
                              text: "Login",
                              style: TextStyle(color: ColorHelper.primarycolor))
                        ])),
                  ),
                ),
                40.SpaceX,
              ],
            ),
          ),
        ));
  }
}
