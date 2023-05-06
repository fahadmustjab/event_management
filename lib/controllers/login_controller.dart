import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/MyHomePage.dart';
import '../widgets/show_snackbar.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final loading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final isvisible = false.obs;

  Future<String> signInWithGoogle(context) async {
    String res = "Some Error occured";
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      if (credential != null) {
        res = "success";
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MyHomePage();
          },
        ));
      }
      showSnackBar(context, type: SnackBarType.success, message: "sucess");
      return res;
    } catch (e) {
      showSnackBar(context, type: SnackBarType.error, message: e.toString());
      return res;
    }
  }

  Future<String> signInWithFacebook(context) async {
    // Trigger the sign-in flow
    String res = "Some Error occured";

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final credential =
          FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      if (credential != null) {
        res = "success";
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MyHomePage();
          },
        ));
      }
      showSnackBar(context, type: SnackBarType.success, message: "sucess");
      return res;
    } catch (e) {
      showSnackBar(context, type: SnackBarType.error, message: e.toString());
      return res;
    }
  }

  void toggleVisibility() {
    isvisible.value = !isvisible.value;
  }

  void setLoading(bool val) {
    loading.value = val;
  }

  void login(context) {
    setLoading(true);
    _auth
        .signInWithEmailAndPassword(
            email: emailController.value.text.toString(),
            password: passwordController.value.text.toString())
        .then((value) {
      showSnackBar(context,
          type: SnackBarType.success, message: 'Login Sucessful');
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return MyHomePage();
        },
      ));
      setLoading(false);
    }).onError((error, stackTrace) {
      showSnackBar(context, type: SnackBarType.info, message: error.toString());
      setLoading(false);
    });
  }
}
