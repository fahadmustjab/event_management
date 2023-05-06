import 'package:event_management/controllers/login_controller.dart';
import 'package:event_management/widgets/custom_text_field.dart';
import 'package:event_management/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/signup_controller.dart';
import '../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                ),
                isSignUp
                    ? myText(
                        text: 'Sign Up',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : myText(
                        text: 'Login',
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                isSignUp
                    ? Container(
                        child: myText(
                          text:
                              'Welcome, Please Sign up to see events and classes from your friends.',
                          style: GoogleFonts.roboto(
                            letterSpacing: 0,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(
                        child: myText(
                          text:
                              'Welcome back, Please Sign in and continue your journey with us.',
                          style: GoogleFonts.roboto(
                            letterSpacing: 0,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  child: TabBar(
                      labelPadding: EdgeInsets.all(Get.height * 0.01),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      onTap: (v) {
                        setState(() {
                          isSignUp = !isSignUp;
                        });
                      },
                      tabs: [
                        myText(
                          text: 'Login',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                        myText(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.6,
                  child: Form(
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [LoginWidget(), SignUpWidget()])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(children: [
        CustomTextField(
          hintText: 'Email',
          inputType: TextInputType.emailAddress,
          prefixIcon: Icon(Icons.mail),
          controller: loginController.emailController.value,
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        CustomTextField(
          hintText: 'Password',
          inputType: TextInputType.emailAddress,
          prefixIcon: Icon(Icons.lock),
          isPassword: true,
          controller: loginController.passwordController.value,
        ),
        Obx(
          () => loginController.loading.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.04),
                  width: Get.width,
                  child: elevatedButton(
                      text: 'Login',
                      onpress: () {
                        loginController.login(context);
                      }),
                ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        myText(
          text: 'Or Connect With',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            socialAppsIcons(
                text: 'assets/fb.png',
                onPressed: () {
                  loginController.signInWithFacebook(context);
                }),
            socialAppsIcons(
                text: 'assets/google.png',
                onPressed: () {
                  loginController.signInWithGoogle(context);
                }),
          ],
        )
      ]),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SignUpController signupController = Get.put(SignUpController());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Column(
      children: [
        CustomTextField(
          hintText: 'Username',
          inputType: TextInputType.emailAddress,
          prefixIcon: Icon(Icons.person),
          controller: signupController.usernameController.value,
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        CustomTextField(
          hintText: 'Email',
          inputType: TextInputType.emailAddress,
          controller: signupController.emailController.value,
          prefixIcon: Icon(Icons.mail),
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        CustomTextField(
          hintText: 'Password',
          inputType: TextInputType.text,
          controller: signupController.passwordController.value,
          prefixIcon: Icon(Icons.lock),
          isPassword: true,
        ),
        Obx(() => signupController.loading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.04),
                width: Get.width,
                child: elevatedButton(
                    text: 'Sign Up',
                    onpress: () {
                      signupController.signup(context);
                    }),
              ))
      ],
    );
  }
}
