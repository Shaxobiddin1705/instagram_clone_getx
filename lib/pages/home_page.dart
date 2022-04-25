import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/home_controller.dart';
import 'package:instagram_clone_getx/pages/my_feed_page.dart';
import 'package:instagram_clone_getx/pages/my_likes_page.dart';
import 'package:instagram_clone_getx/pages/my_profile_page.dart';
import 'package:instagram_clone_getx/pages/my_search_page.dart';
import 'package:instagram_clone_getx/pages/my_upload_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    Get.find<HomeController>().initNotification(context);
    Get.find<HomeController>().pageController.value = PageController(initialPage: 0);
    Get.find<HomeController>().currentTap.value = 0;
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   Get.find<HomeController>().pageController.value = PageController(initialPage: 0);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: Get.find<HomeController>().pageController(),
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          Get.find<HomeController>().currentTap.value = index;
        },
        children: [
          MyFeedPage(),
          MySearchPage(controller: Get.find<HomeController>().pageController(),),
          MyUploadPage(pageController: Get.find<HomeController>().pageController(),),
          const MyLikesPage(),
          MyProfilePage(),
          // OtherProfilePage(pageController: _pageController,),
        ],
      ),

      bottomNavigationBar: GetX<HomeController>(
        init: HomeController(),
        builder: (_) => BottomNavigationBar(
          selectedItemColor: const Color.fromRGBO(193, 53, 132, 1),
          unselectedItemColor: Colors.grey,
          currentIndex: Get.find<HomeController>().currentTap(),
          showSelectedLabels: false,
          onTap: (int index) {
            Get.find<HomeController>().currentTap.value = index;
            Get.find<HomeController>().pageController().animateToPage(index, duration: const Duration(microseconds: 10), curve: Curves.easeIn);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home, size: 28,),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search, size: 28,),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.plus_app, size: 28,),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart_fill, size: 28,),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt_circle, size: 28,),
              label: "",
            ),
          ],

        ),
      ),
    );
  }
}
