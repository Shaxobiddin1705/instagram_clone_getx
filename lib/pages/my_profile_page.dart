import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/my_profile_controller.dart';
import 'package:instagram_clone_getx/pages/edit_profile_page.dart';
import 'package:instagram_clone_getx/pages/my_posts_page.dart';
import 'package:instagram_clone_getx/pages/settings_page.dart';
import 'package:shimmer/shimmer.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  var controllerU = Get.put(MyProfileController());

  @override
  void initState() {
    Get.find<MyProfileController>().loadPosts();
    Get.find<MyProfileController>().apiLoadUser();
  super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetX<MyProfileController>(
        init: MyProfileController(),
        builder: (_) => Get.find<MyProfileController>().isLoading() ? Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator()),
    ) : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              if (kDebugMode) {
                print('pressed');
              }
            },
            child: Row(
              children: [
                Text(
                  Get.find<MyProfileController>().users().userName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24),
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  size: 15,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          actions: [
            //#add
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.plus_app,
                color: Colors.black,
                size: 28,
              ),
              splashRadius: 25,
            ),

            //#menu
            IconButton(
              onPressed: () {
                _bottomSheet();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 28,
              ),
              splashRadius: 25,
            ),
          ],
        ),
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //#Header
              Container(
                margin: const EdgeInsets.only(right: 20, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Stack(
                        children: [

                          Container(
                              height: 110,
                              width: 110,
                              padding: const EdgeInsets.all(13),
                              child: Get.find<MyProfileController>().isLoading() ? const CircularProgressIndicator(strokeWidth: 1.5, color: Color.fromRGBO(193, 53, 132, 1),) : Get.find<MyProfileController>().users().imageUrl != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: Get.find<MyProfileController>().users().imageUrl!,
                                  placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 3, color: Color.fromRGBO(193, 53, 132, 1),),
                                  height: 110,
                                  width: 110,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : const CircleAvatar(
                                radius: 38,
                                backgroundImage: AssetImage(
                                    'assets/images/person_icon.png'),
                              )),

                          Container(
                            alignment: Alignment.bottomRight,
                            width: 98,
                            height: 98,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[200],
                              ),
                              child: const Icon(
                                CupertinoIcons.add_circled_solid,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          Get.find<MyProfileController>().listPosts.length.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text('Posts'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          Get.find<MyProfileController>().users().followersCount.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text('Followers'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          Get.find<MyProfileController>().users().followingCount.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text('Following'),
                      ],
                    ),
                  ],
                ),
              ),

              //#Description
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Get.find<MyProfileController>().users.value.fullName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text('The student of Tashkent Financial Institute'),
                const SizedBox(
                  height: 2,
                ),
                const Text('The flutter developer'),
              ],
            ),
          ),

              const SizedBox(
                height: 10,
              ),

              //#EditAddAccount
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Get.to(EditProfilePage())!.then((value) {
                            Get.find<MyProfileController>().apiLoadUser();
                          });
                        },
                        child: const Text('Edit Profile'),
                        height: 35,
                        minWidth: MediaQuery.of(context).size.width * 0.76,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 38,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.04,
                        onPressed: () {},
                        child: const Icon(
                          CupertinoIcons.person_add,
                          size: 20,
                        ),
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                  ],
                ),
              ),

              //#highlites
              Container(
                  height: 100,
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                //#Image
                                Container(
                                  height: 70,
                                  width: 70,
                                  padding: const EdgeInsets.all(3),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.8)),
                                  ),
                                  child: Container(
                                    // padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    child: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/person_icon.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //#title
                            const Text('title'),
                          ],
                        );
                      })),

              //#Buttons
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.find<MyProfileController>().currentTap.value = 0;
                        Get.find<MyProfileController>().pageController().animateToPage(0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: Icon(CupertinoIcons.rectangle_split_3x3,
                          size: 27,
                          color: Get.find<MyProfileController>().currentTap.value == 0 ? Colors.black : Colors.grey),
                      splashRadius: 25,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.find<MyProfileController>().currentTap.value = 1;
                        Get.find<MyProfileController>().pageController().animateToPage(1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: Icon(CupertinoIcons.play,
                          size: 27,
                          color: Get.find<MyProfileController>().currentTap.value == 1 ? Colors.black : Colors.grey),
                      splashRadius: 25,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.find<MyProfileController>().currentTap.value = 2;
                        Get.find<MyProfileController>().pageController().animateToPage(2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: Icon(Icons.person_pin_outlined,
                          size: 27,
                          color: Get.find<MyProfileController>().currentTap.value == 2 ? Colors.black : Colors.grey),
                      splashRadius: 25,
                    ),
                  ],
                ),
              ),

              //PostImages
              Container(
                height: ((Get.find<MyProfileController>().listPosts.length / 3) <= 1) ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * (Get.find<MyProfileController>().listPosts.length /3 - Get.find<MyProfileController>().listPosts.length % 3) * 0.2,
                child: PageView(
                  controller: Get.find<MyProfileController>().pageController(),
                  onPageChanged: (int index) {
                    Get.find<MyProfileController>().currentTap.value = index;
                  },
                  children: [
                    _gridView(),
                    _gridView(),
                    _gridView(),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  Widget _gridView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2),
        itemCount: Get.find<MyProfileController>().listPosts.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MyPostsPage.id).then((value) => Get.find<MyProfileController>().apiLoadUser());
            },
            child: CachedNetworkImage(
              imageUrl: Get.find<MyProfileController>().listPosts[index].postImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.5,
                  // width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        });
  }

  void _bottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),

                //#settings
                _listTile(
                    icon: CupertinoIcons.gear,
                    text: "Settings",
                    goingPage: SettingsPage.id),

                //#yourActivity
                _listTile(icon: CupertinoIcons.timer, text: "Your activity"),

                //#archives
                _listTile(icon: CupertinoIcons.time, text: "Archives"),

                //#QRcode
                _listTile(
                    icon: CupertinoIcons.qrcode_viewfinder, text: "QR code"),

                //#saved
                _listTile(icon: CupertinoIcons.bookmark, text: "Saved"),

                //#closeFriends
                _listTile(
                    icon: CupertinoIcons.square_favorites,
                    text: "Close Friends"),

                //#closeFriends
                _listTile(
                    icon: CupertinoIcons.heart_circle,
                    text: "COVID-19 Information Center"),
              ],
            ),
          );
        }
    );
  }

  Widget _listTile({required icon, required text, goingPage}) {
    return ListTile(
      minVerticalPadding: 0.0,
      leading: Icon(
        icon,
        color: Colors.black,
        size: 28,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 17),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
      onTap: () {
        _go(page: goingPage);
      },
    );
  }

  _go({page}) {
    Navigator.popAndPushNamed(context, page);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      Get.find<MyProfileController>().imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    Get.find<MyProfileController>().imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
