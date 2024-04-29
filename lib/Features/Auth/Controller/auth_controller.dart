import 'package:ecom_app/Core/Common/custom_snackbar.dart';
import 'package:ecom_app/Core/Common/nav_bar/nav_bar.dart';
import 'package:ecom_app/Core/Common/snack_bar.dart';
import 'package:ecom_app/Features/Auth/Repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider(
  (ref) => AuthController(repository: ref.watch(authRepositoryProvider)),
);

class AuthController {
  final AuthRepository _repository;
  AuthController({required AuthRepository repository})
      : _repository = repository;

  signupWithEmail(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    final res = await _repository.signupWithEmail(email: email, pass: pass);
    res.fold(
      (l) {
        showSnackBarDialogue(context, "message");
      },
      (r) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavBar(),
          ),
          (route) => false,
        );
      },
    );
  }

  loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    // final res = await _repository.loginWithEmail(
    //     email: email,
    //     password: password,
    //     function: () {

    //     });

    final res = await _repository.signinUser(email, password);

    res.fold(
      (l) {
        customSnackbar(context, l.message, isError: true);
      },
      (r) {
        customSnackbar(context, "success", isSuccess: true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ),
          (route) => false,
        );
      },
    );
  }
}
