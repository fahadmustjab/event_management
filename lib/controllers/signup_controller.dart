import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/MyHomePage.dart';
import '../widgets/show_snackbar.dart';

class SignUpController extends GetxController {
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> bioController = TextEditingController().obs;
  Rx<XFile?> imageXFile = null.obs;
  final ImagePicker _picker = ImagePicker();
  final loading = false.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future pickImage() async {
    imageXFile.value = await _picker.pickImage(source: ImageSource.gallery);
  }

  void setLoading(value) {
    loading.value = value;
  }

  Future<String> signup(context) async {
    String res = "show error occured";
    setLoading(true);
    try {
      final cred = await auth.createUserWithEmailAndPassword(
          email: emailController.value.text.toString(),
          password: passwordController.value.text.toString());

      firestore.collection('users').doc(cred.user!.uid).set({
        'username': usernameController.value.text.toString(),
        'uid': cred.user!.uid,
        'email': emailController.value.text.toString(),
        'bio': bioController.value.text.toString(),
        'followers': [],
      });
      setLoading(false);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return MyHomePage();
        },
      ));
      showSnackBar(context,
          type: SnackBarType.success, message: 'Register Sucessful');

      res = "success";
    } catch (e) {
      print(e);
      setLoading(false);
      showSnackBar(context, type: SnackBarType.error, message: e.toString());
    }
    return res;
  }
}
