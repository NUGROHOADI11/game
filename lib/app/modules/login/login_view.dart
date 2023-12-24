import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_pages.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  final height = Get.mediaQuery.size.height * 1;
  final width = Get.mediaQuery.size.width * 1;
  final emailControl = TextEditingController();
  final passControl = TextEditingController();
  final authControl = Get.find<AuthController>();

  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: height * 1.8,
          width: width * 1.8,
          child: Image.asset(
            "assets/images/Login.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: height * 0.5,
            width: width * 0.9,
            child: Text(
              "Welcome\nBack!",
              style: GoogleFonts.sora(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: height * 0.38,
            width: width * 0.9,
            child: Center(
                child: Column(
              children: [
                TextField(
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.black),
                  controller: emailControl,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Change the color as needed
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Change the color as needed
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.black),
                  controller: passControl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Change the color as needed
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Change the color as needed
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    if (emailControl.text.isEmpty || passControl.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter both email and password.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                      return;
                    }
                    bool loginSuccess = await authControl.login(
                        emailControl.text, passControl.text);

                    if (loginSuccess) {
                      Get.snackbar(
                        'Success',
                        'Login successful!',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        'Login failed. Check your credentials.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                    }
                  },
                  child: Container(
                      height: 50,
                      width: 900,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      )),
                ),
                Row(
                  children: [
                    Text(
                      "Don't have any account?",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.SIGNUP),
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
        ),
      ]),
    );
  }
}
