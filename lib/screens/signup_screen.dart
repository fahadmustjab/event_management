import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../widgets/custom_text_field.dart';
import 'login_signup_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Enter your Name',
                    controller: signupController.usernameController.value,
                    inputType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Enter your Email',
                    controller: signupController.emailController.value,
                    inputType: TextInputType.name,
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Enter your Password',
                    controller: signupController.passwordController.value,
                    inputType: TextInputType.name,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Enter your bio',
                    controller: signupController.bioController.value,
                    inputType: TextInputType.name,
                    prefixIcon: const Icon(Icons.person_add_sharp),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Obx(
                  () => InkWell(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: Colors.blue,
                      ),
                      child: signupController.loading.value == false
                          ? const Text(
                              'Sign up',
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                    onTap: () async {
                      String res = await signupController.signup(context);
                      print(res);
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        'Already have an account?',
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                      child: Container(
                        child: const Text(
                          ' Login.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
