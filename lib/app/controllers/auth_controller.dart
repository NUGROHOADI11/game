import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  Future<bool> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Get.offAllNamed(Routes.HOME);
      return true; // Indicate login success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false; // Indicate login failure
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<bool> signup(String email, String pass) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Get.offAllNamed(Routes.LOGIN);
      return true; // Indicate login success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false; // Indicate login failure
    }
  }
}
