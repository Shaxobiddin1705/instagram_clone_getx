import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/pages/home_page.dart';
import 'package:instagram_clone_getx/services/auth_service.dart';
import 'package:instagram_clone_getx/services/hive_service.dart';
import 'package:instagram_clone_getx/services/utils.dart';

class SignInController extends GetxController{

  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var isLoading = false.obs ;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> doSignIn(context) async{
    String email = emailController().text.trim().toString();
    String password = passwordController().text.trim().toString();

    if(email.isEmpty || password.isEmpty) {
      Get.snackbar(
        '', '',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        backgroundColor: Colors.grey.shade300,
        colorText: Colors.black,
        messageText: const Center(child: Text('Please complete all the fields', style: TextStyle(fontSize: 16),)),
        titleText: const SizedBox.shrink(),
      );
      return;
    }

    isLoading.value = true;

    await AuthService.signInUser(email, password).then((response) {
      getFirebaseUser(response, context);
    });
  }

  void getFirebaseUser(Map<String, User?> map, context) async {
    isLoading.value = false;

    if(!map.containsKey("SUCCESS")) {
      if(map.containsKey("user-not-found")) {
        // Utils.fireSnackBar("No user found for that email.", context);
        Get.snackbar(
          '', '',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          backgroundColor: Colors.grey.shade300,
          colorText: Colors.black,
          messageText: const Center(child: Text('No user found for that email.', style: TextStyle(fontSize: 16),)),
          titleText: const SizedBox.shrink(),
        );
      }
        if(map.containsKey("wrong-password")) {
          // Utils.fireSnackBar("Wrong password provided for that user.", context);
          Get.snackbar(
            '', '',
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            backgroundColor: Colors.grey.shade300,
            colorText: Colors.black,
            messageText: const Center(child: Text('Wrong password provided for that user.', style: TextStyle(fontSize: 16),)),
            titleText: const SizedBox.shrink(),
          );
        }
        if(map.containsKey("ERROR")) {
          // Utils.fireSnackBar("Check Your Information.", context);
          Get.snackbar(
            '', '',
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            backgroundColor: Colors.grey.shade300,
            colorText: Colors.black,
            messageText: const Center(child: Text('Check Your Information.', style: TextStyle(fontSize: 16),)),
            titleText: const SizedBox.shrink(),
          );
        return;
      }
    }

    User? user = map["SUCCESS"];
    if(user == null) return;

    HiveDB.store(user.uid);
    Get.offAll(HomePage());
  }

  void authenticateUser() async{
    String email = emailController().text.trim().toString();
    String password = passwordController().text.trim().toString();

    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential);
  }

  initNotification() async {
    await _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      if (kDebugMode) {
        print(token);
      }
      HiveDB.saveFCM(token!);
    });
  }

}