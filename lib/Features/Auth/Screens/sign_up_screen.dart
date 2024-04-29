import 'package:ecom_app/Core/Common/custom_textform_field/custom_textform.dart';
import 'package:ecom_app/Core/Common/nav_bar/nav_bar.dart';
import 'package:ecom_app/Features/Auth/Controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/Common/Components/components.dart';
import '../../../Core/Common/services.dart';
import '../../../main.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(name, email, userCredential.user!.uid);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBar(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: logo,
        titleSpacing: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign up',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: w * 0.1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Text(
                      'Please fill in the following fields.',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: w * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.04,
                    ),

                    SizedBox(
                      width: w * 0.9,
                      child: CustomTextField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          label: 'Name'),
                    ),
                    SizedBox(
                      height: h * 0.025,
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
                      height: h * 0.025,
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
                      height: h * 0.025,
                    ),
                    SizedBox(
                      width: w * 0.9,
                      child: CustomTextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone'),
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    //Login Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        defaultButton(
                          onPressed: () {
                            signupUser(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                nameController.text.trim(),
                                context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SIGN UP',
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
          ],
        ),
      ),
    );
  }
}
