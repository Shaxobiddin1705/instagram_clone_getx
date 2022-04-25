import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/pages/home_page.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:instagram_clone_getx/services/hive_service.dart';

class SplashController extends GetxController{

  Timer? timer;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void goSignInPage(context) {
    Navigator.pushReplacementNamed(context, HomePage.id);
    timer!.cancel();
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
    Users users = await DataService.loadUser();
    String token = await HiveDB.loadFCM();
    users.deviceToken = token;
    await DataService.updateUser(users);
  }

}