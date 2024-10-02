import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/utils/colors.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

Widget text(
  String? text, {
  var fontSize = 18.0,
  Color? textColor,
  var isCentered = false,
  FontWeight fontWeight = FontWeight.normal,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor ?? textSecondaryColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

Widget commonCacheImageWidget(String? url,
    {double? height, double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder:
            placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorWidget: (_, __, ___) {
          return SizedBox(height: height, width: width);
        },
      );
    } else {
      return Image.network(url!,
          height: height, width: width, fit: fit ?? BoxFit.cover);
    }
  } else {
    return Image.asset(url!,
        height: height, width: width, fit: fit ?? BoxFit.cover);
  }
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  const CustomTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: child!,
    );
  }
}

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() =>
    Image.asset('images/quiz/empty_image_placeholder.jpg', fit: BoxFit.cover);

showToast(String caption) {
  Fluttertoast.showToast(
      msg: caption,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: getColorFromHex('5362FB'),
      textColor: ColorHelper.whitecolor,
      fontSize: 16.0);
}

class SelectUser extends StatelessWidget {
  final String label;
  final String image;
  final Color selectedcolor;
  final VoidCallback ontap;
  const SelectUser(
      {super.key,
      required this.label,
      required this.image,
      required this.selectedcolor,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: selectedcolor, width: 1.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: Get.width * .2,
              ),
              5.SpaceX,
              text(label, textColor: selectedcolor)
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.ontap, required this.label});

  final String label;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: Get.width * .6,
        decoration: BoxDecoration(
            color: ColorHelper.primarycolor,
            borderRadius: BorderRadius.circular(12)),
        child: text(label,
            fontSize: 20.0,
            textColor: ColorHelper.whitecolor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String hinttext;
  final bool? isobscure;
  final Function(String)? onsubmit;
  final FocusNode? focusnode;
  final VoidCallback? ontap;

  const PrimaryTextField(
      {super.key,
      required this.controller,
      this.ontap,
      this.prefixIcon,
      this.onsubmit,
      this.suffixIcon,
      this.isobscure,
      this.focusnode,
      required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusnode,
      onSubmitted: onsubmit,
      onTapOutside: (val) {
        hideKeyboard(context);
      },
      onTap: ontap,
      controller: controller,
      obscureText: isobscure ?? false,
      decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          hintText: hinttext,
          border: const UnderlineInputBorder()),
    );
  }
}
