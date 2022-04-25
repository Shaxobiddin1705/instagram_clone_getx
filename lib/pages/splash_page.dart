import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String id = 'splash_page';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    Get.find<SplashController>().initNotification();
    Get.find<SplashController>().timer = Timer(const Duration(milliseconds: 2000), () {
      Get.find<SplashController>().goSignInPage(context);
    } );
    super.initState();
  }


  @override
  void dispose() {
    Get.find<SplashController>().timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1),

              // Color.fromRGBO(252, 175, 69, 1),
              // Color.fromRGBO(245, 96, 64, 1),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [

            Expanded(
                child: Center(
                  child: Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: "Billabong"),),
                )
            ),

            Text('All right reserved', style: TextStyle(color: Colors.white, fontSize: 16),),

            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
