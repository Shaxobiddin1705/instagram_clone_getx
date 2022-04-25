import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/sign_in_controller.dart';
import 'package:instagram_clone_getx/pages/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String id = 'sign_in_page';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


  @override
  void initState() {
    Get.find<SignInController>().initNotification();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<SignInController>().emailController().clear();
    Get.find<SignInController>().passwordController().clear();
  }


  @override
  Widget build(BuildContext context) {
    return GetX<SignInController>(
        init: SignInController(),
        builder: (_) => Scaffold(
      body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                  children: [

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: "Billabong"),),

                          const SizedBox(height: 20,),

                          //#Email
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: TextField(
                              controller: Get.find<SignInController>().emailController(),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                border:InputBorder.none,
                                hintStyle: TextStyle(fontSize: 17.0, color: Colors.white54),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10,),

                          //#Password
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: TextField(
                              controller: Get.find<SignInController>().passwordController(),
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Password",
                                border:InputBorder.none,
                                hintStyle: TextStyle(fontSize: 17.0, color: Colors.white54),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10,),

                          //#SignInButton
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            // padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white54.withOpacity(0.2), width: 2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                Get.find<SignInController>().doSignIn(context);
                                Get.find<SignInController>().authenticateUser();
                                // Navigator.pushReplacementNamed(context, HomePage.id);
                              },
                              child: const Text('Sign In', style: TextStyle(fontSize: 17, color: Colors.white),),
                            ),
                          ),


                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text('Don`t have an account?', style: TextStyle(color: Colors.white, fontSize: 16),),

                        const SizedBox(width: 10,),

                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, SignUpPage.id);
                          },
                          child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              Get.find<SignInController>().isLoading() ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ) ) : const SizedBox.shrink(),
            ],
          )
      ),
    ),
    );
  }
}
