import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../../main.dart';

void navigateAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Widget login(context) => Text(
      'Login',
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: w * 0.1,
        fontWeight: FontWeight.w700,
      ),
    );

Widget askToCreate(context) => Text(
      "Don't have an account?",
      style: GoogleFonts.poppins(color: Colors.black, fontSize: w * 0.04),
    );

Widget defaultButton({
  required Function() onPressed,
  Widget? child,
}) =>
    MaterialButton(
      onPressed: onPressed,
      highlightColor: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 7.5,
      ),
      child: child,
      color: Colors.orange,
    );

void defaultToast({
  required BuildContext context,
  required String message,
  required Color iconColor,
  required IconData icon,
}) {
  MotionToast(
    description: Text(
      message,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16.0,
      ),
    ),
    primaryColor: HexColor('DEDEDE'),
    animationDuration: Duration(
      milliseconds: 500,
    ),
    toastDuration: Duration(seconds: 5),
    displaySideBar: false,
    icon: icon,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    secondaryColor: iconColor,
    enableAnimation: false,
    constraints: BoxConstraints(),
    // padding: EdgeInsets.all(20.0.sp),
  ).show(context);
}

Widget logo = Row(
  children: [
    Icon(
      Icons.shopping_bag,
      color: Colors.orange,
      size: w * 0.1,
    ),
    Text(
      'Shopify',
      style:
          GoogleFonts.poppins(fontSize: w * 0.09, fontWeight: FontWeight.w500),
    ),
  ],
);

Widget loading = SizedBox(
  width: 35.0,
  height: 35.0,
  child: CircularProgressIndicator(
    color: Colors.orange,
  ),
);
