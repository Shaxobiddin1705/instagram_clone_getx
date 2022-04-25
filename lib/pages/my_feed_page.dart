import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/my_feed_controller.dart';
import 'package:shimmer/shimmer.dart';
class MyFeedPage extends StatefulWidget {
  MyFeedPage({Key? key, this.message}) : super(key: key);
  static const String id = 'my_feed_page';
  String? message;

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {

  @override
  void initState() {
    Get.find<MyFeedController>().loadPosts();
    Get.find<MyFeedController>().apiLoadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Instagram', style: TextStyle(fontSize: 30, fontFamily: 'Billabong', color: Colors.black),),

        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(CupertinoIcons.bolt_horizontal_circle, color: Colors.black,)
          ),
        ],
      ),

      body: GetX<MyFeedController>(
        init: MyFeedController(),
        builder: (_) => Stack(
          children: [
            Get.find<MyFeedController>().posts.isNotEmpty ? ListView.builder(
                itemCount: Get.find<MyFeedController>().posts.length,
                itemBuilder: (context, index) {
                  return _post(index: index);
                }
            ) : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: const Center(
                child: Text('No posts yet', style: TextStyle(fontSize: 19),),
              ),
            ),
            Get.find<MyFeedController>().isLiking() ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 250,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _post({index}) {
    return (Get.find<MyFeedController>().isLoading() || Get.find<MyFeedController>().users == null) ? SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ) : SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 10,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [

                //#UserImageUserName
                Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  child: Row(
                    children: [

                      Get.find<MyFeedController>().users == null || Get.find<MyFeedController>().posts[index].imageUser == null ?
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/person_icon.png'),
                      ) : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: Get.find<MyFeedController>().posts[index].imageUser!,
                          placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 3, color: Color.fromRGBO(193, 53, 132, 1),),
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 10,),

                      Text(Get.find<MyFeedController>().posts[index].userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),)
                    ],
                  ),
                ),

                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.more_horiz_rounded),
                  splashRadius: 20,
                )

              ],
            ),
          ),

          const SizedBox(height: 10,),

          //#Image
          GestureDetector(
            onDoubleTap: () {
              if(!Get.find<MyFeedController>().posts[index].isLiked) {
                Get.find<MyFeedController>().apiPostLike(Get.find<MyFeedController>().posts[index]);
              }else{
                Get.find<MyFeedController>().apiPostUnlike(Get.find<MyFeedController>().posts[index]);
              }
            },
            child: CachedNetworkImage(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              imageUrl: Get.find<MyFeedController>().posts[index].postImage, fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [

                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //#heart
                      IconButton(
                        onPressed: (){
                          if(!Get.find<MyFeedController>().posts[index].isLiked) {
                            Get.find<MyFeedController>().apiPostLike(Get.find<MyFeedController>().posts[index]);
                          }else{
                            Get.find<MyFeedController>().apiPostUnlike(Get.find<MyFeedController>().posts[index]);
                          }
                        },
                        icon: Icon(
                          Get.find<MyFeedController>().posts[index].isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                          color: Get.find<MyFeedController>().posts[index].isLiked ?Colors.red : Colors.black,
                        ),
                        splashRadius: 20,
                      ),

                      //#commint
                      IconButton(
                        onPressed: () async{},
                        icon: Image.asset('assets/images/chat.png', height: 28,),
                        splashRadius: 20,
                      ),

                      //#send
                      IconButton(
                        onPressed: (){
                          Get.find<MyFeedController>().share(index);
                        },
                        icon: const Icon(CupertinoIcons.paperplane),
                        splashRadius: 20,
                      ),

                    ],
                  ),
                ),

                Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        //#Save
                        IconButton(
                          onPressed: (){},
                          icon: const Icon(CupertinoIcons.bookmark),
                          splashRadius: 20,
                        ),
                      ],
                    )
                ),

              ],
            ),
          ),

          Container(
              margin: const EdgeInsets.only(left: 20,),
              child: Text(Get.find<MyFeedController>().posts[index].createdDate, style: const TextStyle(color: Colors.grey),)
          ),

          const SizedBox(height: 3,),

          Container(
            margin: const EdgeInsets.only(left: 20,),
            child: Text(Get.find<MyFeedController>().posts[index].caption, maxLines: 2, style: const TextStyle(fontSize: 16),),
          ),

        ],
      ),
    );
  }
}
