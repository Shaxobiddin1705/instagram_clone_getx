import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/other_profile_controller.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/pages/my_posts_page.dart';
import 'package:shimmer/shimmer.dart';

class OtherProfilePage extends StatefulWidget {
  OtherProfilePage({Key? key, this.pageController, this.users}) : super(key: key);
  static const String id = 'other_profile_page';
  PageController? pageController;
  Users? users;

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {

  @override
  void initState() {
    Get.find<OtherProfileController>().loadPosts(widget.users);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  GetX<OtherProfileController>(
        init: OtherProfileController(),
        builder: (_) => Get.find<OtherProfileController>().isLoading() ? Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator()),
    ) : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print('pressed');
            }
          },
          child: Text(
            widget.users!.userName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24),
          ),
        ),
        actions: [
          //#bell
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.black,
              size: 28,
            ),
            splashRadius: 25,
          ),

          //#more
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.black,
              size: 28,
            ),
            splashRadius: 25,
          ),
        ],
      ),
      body:  Stack(
        children: [
          SingleChildScrollView(
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
                          // _showPicker(context);
                        },
                        child: Container(
                            height: 110,
                            width: 110,
                            padding: const EdgeInsets.all(13),
                            child: Get.find<OtherProfileController>().isLoading() ? const CircularProgressIndicator(strokeWidth: 1.5, color: Color.fromRGBO(193, 53, 132, 1),) : widget.users!.imageUrl != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: widget.users!.imageUrl!,
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
                      ),

                      Column(
                        children: [
                          Text(
                            Get.find<OtherProfileController>().listPosts.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text('Posts'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            widget.users!.followersCount.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text('Followers'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            widget.users!.followingCount.toString(),
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
                        widget.users!.fullName,
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

                //#FollowingMessage

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

                const SizedBox(height: 10,),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 30,
                        width: 150,
                        child: MaterialButton(
                          minWidth: 150,
                          elevation: 0,
                          onPressed: (){
                            if(widget.users!.followed){
                              Get.find<OtherProfileController>().apiUnFollowUser(widget.users!);
                            }else{
                              Get.find<OtherProfileController>().apiFollowUser(widget.users!);
                            }
                          },
                          color: widget.users!.followed ? Colors.white : Colors.blue,
                          child: Text(widget.users!.followed ? 'Following' : 'Follow', style: TextStyle(color: widget.users!.followed ? Colors.black : Colors.white),),
                        ),
                      ),

                      const SizedBox(width: 8,),

                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        height: 30,
                        width: 150,
                        child: MaterialButton(
                          elevation: 0,
                          minWidth: 150,
                          onPressed: (){},
                          child: const Text('Message'),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 10,),

                //#Buttons
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Get.find<OtherProfileController>().currentTap.value = 0;
                            Get.find<OtherProfileController>().pageController().animateToPage(0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                        },
                        icon: Icon(CupertinoIcons.rectangle_split_3x3,
                            size: 27,
                            color: Get.find<OtherProfileController>().currentTap.value == 0 ? Colors.black : Colors.grey),
                        splashRadius: 25,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Get.find<OtherProfileController>().currentTap.value = 1;
                            Get.find<OtherProfileController>().pageController().animateToPage(1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                        },
                        icon: Icon(CupertinoIcons.play,
                            size: 27,
                            color: Get.find<OtherProfileController>().currentTap.value == 1 ? Colors.black : Colors.grey),
                        splashRadius: 25,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Get.find<OtherProfileController>().currentTap.value = 2;
                            Get.find<OtherProfileController>().pageController().animateToPage(2,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                        },
                        icon: Icon(Icons.person_pin_outlined,
                            size: 27,
                            color: Get.find<OtherProfileController>().currentTap.value == 2 ? Colors.black : Colors.grey),
                        splashRadius: 25,
                      ),
                    ],
                  ),
                ),

                //PostImages
                SizedBox(
                  height: ((Get.find<OtherProfileController>().listPosts.length /3) < 1) ? MediaQuery.of(context).size.height * 0.2
                      : MediaQuery.of(context).size.height * (Get.find<OtherProfileController>().listPosts.length /3 - Get.find<OtherProfileController>().listPosts.length % 3) * 0.2,
                  child: PageView(
                    controller: Get.find<OtherProfileController>().pageController(),
                    onPageChanged: (int index) {
                      setState(() {
                        Get.find<OtherProfileController>().currentTap.value = index;
                      });
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
          ),
          Get.find<OtherProfileController>().isFollowing() ? SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            child: const Center(child: CircularProgressIndicator(),),
          ) : const SizedBox.shrink(),
        ],
      ),
    ),
    );
  }

  Widget _gridView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2),
        itemCount: Get.find<OtherProfileController>().listPosts.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MyPostsPage.id);
            },
            child: CachedNetworkImage(
              imageUrl: Get.find<OtherProfileController>().listPosts[index].postImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        });
  }
}
