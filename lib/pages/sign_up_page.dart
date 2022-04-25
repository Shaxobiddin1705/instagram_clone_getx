import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/sign_up_controller.dart';
import 'package:instagram_clone_getx/pages/sign_in_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String id = 'sign_up_page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<SignUpController>().fullNameController().clear();
    Get.find<SignUpController>().emailController().clear();
    Get.find<SignUpController>().userNameController().clear();
    Get.find<SignUpController>().passwordController().clear();
    Get.find<SignUpController>().confirmPasswordController().clear();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<SignUpController>(
        init: SignUpController(),
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

                          //#FullName
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: TextField(
                              controller: Get.find<SignUpController>().fullNameController(),
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "FullName",
                                border:InputBorder.none,
                                hintStyle: TextStyle(fontSize: 17.0, color: Colors.white54),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10,),

                          //#Email
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: TextField(
                              controller: Get.find<SignUpController>().emailController(),
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

                          //#UserName
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: TextField(
                              controller: Get.find<SignUpController>().userNameController(),
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "UserName",
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
                              controller: Get.find<SignUpController>().passwordController(),
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

                          //#ConfirmPassword
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: TextField(
                              controller: Get.find<SignUpController>().confirmPasswordController(),
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Confirm Password",
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
                                Get.find<SignUpController>().doSignUp(context);
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Text('Already have an account?', style: TextStyle(color: Colors.white, fontSize: 16),),

                        const SizedBox(width: 10,),

                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, SignInPage.id);
                          },
                          child: const Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              Get.find<SignUpController>().isLoading() ? SizedBox(
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
