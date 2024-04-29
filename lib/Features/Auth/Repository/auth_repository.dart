import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/Core/Common/failure.dart';
import 'package:ecom_app/Core/Common/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../Core/Common/type_def.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      firestore: ref.read(fireStroeProvider),
      firebaseAuth: ref.read(fireAuthProvider)),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  /// signup
  FutureVoid signupWithEmail(
      {required String email, required String pass}) async {
    try {
      return right(
        _firebaseAuth
            .createUserWithEmailAndPassword(password: pass, email: email)
            .then((value) {
          FirebaseFirestore.instance
              .collection('user')
              .doc(value.user!.uid)
              .set({
            "email": value.user!.email,
            "password": pass,
            "username": value.user?.displayName ?? "",
            "date": FieldValue.serverTimestamp()
          });
        }),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  ///login

  FutureVoid loginWithEmail(
      {required String email,
      required String password,
      required void Function() function}) async {
    try {
      _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          function();
        },
      );
      return right("Success");
    } on FirebaseException catch (e) {
      print('dljnsjldnjlsdnvads-----------------------------------------$e');
      throw e.message!;
    } catch (e) {
      print('diffbvkfbvdkfvndfk-----------------------------------------$e');
      return left(Failure(e.toString()));
    }
  }

  FutureVoid signinUser(
    String email,
    String password,
  ) async {
    try {
      return right(await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  // static signinUser(String email, String password, BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('You are Logged in')));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('No user Found with this Email')));
  //     } else if (e.code == 'wrong-password') {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Password did not match')));
  //     }
  //   }
  // }
}
