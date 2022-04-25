import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/pages/sign_in_page.dart';
import 'package:instagram_clone_getx/services/auth_service.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:instagram_clone_getx/services/hive_service.dart';
import 'package:instagram_clone_getx/services/utils.dart';

class SignUpController extends GetxController{

  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var fullNameController = TextEditingController().obs;
  var userNameController = TextEditingController().obs;
  var isLoading = false.obs;

  Future<void> doSignUp(context) async{
    String fullName = fullNameController().text.trim().toString();
    String email = emailController().text.trim().toString();
    String password = passwordController().text.trim().toString();
    String confirmPassword = confirmPasswordController().text.trim().toString();
    String userName = userNameController().text.trim().toString();
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if(email.isEmpty || password.isEmpty || userName.isEmpty || fullName.isEmpty || confirmPassword.isEmpty) {
      // Utils.fireSnackBar("Please complete all the fields", context);
      Get.rawSnackbar(title: "Please complete all the fields");
      isLoading.value = false;
      return ;
    }

    isLoading.value = true;

    if(!emailRegExp.hasMatch(email)) {
      Get.snackbar(
          '', '',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          backgroundColor: Colors.grey.shade300,
          colorText: Colors.black,
          messageText: const Center(child: Text('Please complete the email', style: TextStyle(fontSize: 16),)),
          titleText: const SizedBox.shrink(),
      );
      isLoading.value = false;
      return;
    }

    if(!passwordRegExp.hasMatch(password)) {
      Get.snackbar(
        '', '',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        backgroundColor: Colors.grey.shade300,
        colorText: Colors.black,
        messageText: const Center(child: Text('Please complete the password', style: TextStyle(fontSize: 16),)),
        titleText: const SizedBox.shrink(),
      );
      isLoading.value = false;
      return;
    }

    if(password != confirmPassword) {
      Get.snackbar(
        '', '',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        backgroundColor: Colors.grey.shade300,
        colorText: Colors.black,
        messageText: const Center(child: Text('Your confirm password is different with password', style: TextStyle(fontSize: 16),)),
        titleText: const SizedBox.shrink(),
      );
      isLoading.value = false;
      return;
    }

    var modelUser = Users(password: password, email: email, fullName:  fullName, userName: userName);
    await AuthService.signUpUser(modelUser).then((response) {
      _getFireBaseUser(modelUser, response, context);
    });
  }

  void _getFireBaseUser(Users? users, Map<String, User?> map, context) {
    isLoading.value = false;

    if(!map.containsKey("SUCCESS")) {
      if(map.containsKey("weak-password")) Utils.fireSnackBar("The password provided is too weak.", context);
      if(map.containsKey("email-already-in-use")) Utils.fireSnackBar("The account already exists for that email.", context);
      if(map.containsKey("ERROR")) Utils.fireSnackBar("Check Your Information.", context);
      return;
    }

    User? user = map["SUCCESS"];
    if(user == null) return;

    HiveDB.store(user.uid);
    users?.uid = user.uid;

    DataService.storeUser(users!).then((value) => {Navigator.pushReplacementNamed(context, SignInPage.id)});
  }

}