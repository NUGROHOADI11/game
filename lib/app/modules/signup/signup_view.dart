import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_pages.dart';
import 'signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final height = Get.mediaQuery.size.height * 1;
  final width = Get.mediaQuery.size.width * 1;
  final emailControl = TextEditingController();
  final passControl = TextEditingController();
  final confirmPassControl = TextEditingController();
  final authControl = Get.find<AuthController>();
  bool isValidEmail(String email) {
    return email.contains('@');
  }

  SignupView({Key? key}) : super(key: key);

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
              "Start Your\nJourney Now!",
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
            height: height * 0.45,
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
                TextField(
                  cursorColor: Colors.blue,
                  controller: confirmPassControl,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
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
                    } else if (passControl.text.length <= 6) {
                      Get.snackbar(
                        'Error',
                        'Password at least 6 character ',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                    } else if (passControl.text != confirmPassControl.text) {
                      Get.snackbar(
                        'Error',
                        'Confirm Password Error ',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                    } else if (!isValidEmail(emailControl.text)) {
                      Get.snackbar(
                        'Error',
                        'Invalid email format.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                      return;
                    }

                    bool signUpSuccess = await authControl.signup(
                        emailControl.text, passControl.text);
                    if (signUpSuccess) {
                      Get.snackbar(
                        'Success',
                        'Signup successful!',
                        backgroundColor: Colors.green,
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
                          "Sign Up",
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
                      "Already have any account?",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () => Get.toNamed(Routes.LOGIN),
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ))
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
