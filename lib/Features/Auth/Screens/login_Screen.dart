import 'package:ecom_app/Core/Common/custom_textform_field/custom_textform.dart';
import 'package:ecom_app/Features/Auth/Controller/auth_controller.dart';
import 'package:ecom_app/Features/Auth/Screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/Common/Components/components.dart';
import '../../../Core/Common/nav_bar/nav_bar.dart';
import '../../../main.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBar(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print("object");
      print(e.message);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: logo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    login(context),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Text(
                      'Please Sign in to continue.',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: w * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.06,
                    ),
                    //email
                    SizedBox(
                      width: w * 0.9,
                      child: CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email'),
                    ),

                    SizedBox(
                      height: h * 0.04,
                    ),
                    //password
                    SizedBox(
                      width: w * 0.9,
                      child: CustomTextField(
                          isPassword: true,
                          controller: passwordController,
                          label: 'Password'),
                    ),

                    SizedBox(
                      height: h * 0.020,
                    ),
                    //Login Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        defaultButton(
                          onPressed: () {
                            ref.read(authControllerProvider).loginWithEmail(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                context: context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LOGIN',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                width: w * 0.01,
                              ),
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                                size: w * 0.07,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                askToCreate(context),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.orange,
                      fontSize: w * 0.04,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
