import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/my_posts_controller.dart';
import 'package:shimmer/shimmer.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({Key? key}) : super(key: key);
  static const String id = 'my_posts_page';

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {

  @override
  void initState() {
    Get.find<MyPostsController>().apiLoadUser();
    Get.find<MyPostsController>().loadPosts();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetX<MyPostsController>(
        init: MyPostsController(),
        builder: (_) => (!Get.find<MyPostsController>().isLoading() && Get.find<MyPostsController>().users() != null) ? Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(Get.find<MyPostsController>().users().userName, style: const TextStyle(color: Colors.grey, fontFamily: 'Billabong', fontSize: 18),),
                const Text('Posts', style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          body: Get.find<MyPostsController>().myPosts.isNotEmpty ? ListView.builder(
              itemCount: Get.find<MyPostsController>().myPosts.length,
              itemBuilder: (context, index) {
                return _post(index: index);
              }
          ) : SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text('There is no post yet'),
            ),
          ),
        ) : Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 200,
          child: const Center(child: CircularProgressIndicator()),
        ),
    );
  }

  Widget _post({required index}) {
    return Stack(
      children: [
        SizedBox(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.82,
                      child: Row(
                        children: [

                          Get.find<MyPostsController>().myPosts[index].imageUser == null ?
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/images/person_icon.png'),
                          ) : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: Get.find<MyPostsController>().myPosts[index].imageUser!,
                              placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 3, color: Color.fromRGBO(193, 53, 132, 1),),
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 10,),

                          Text(Get.find<MyPostsController>().myPosts[index].userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),)
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: (){
                        _bottomSheet(index);
                      },
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
                  if(!Get.find<MyPostsController>().myPosts[index].isLiked) {
                    Get.find<MyPostsController>().apiPostLike(Get.find<MyPostsController>().myPosts[index]);
                  }else{
                    Get.find<MyPostsController>().apiPostUnlike(Get.find<MyPostsController>().myPosts[index]);
                  }
                },
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: Get.find<MyPostsController>().myPosts[index].postImage, fit: BoxFit.cover,
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
                              if(!Get.find<MyPostsController>().myPosts[index].isLiked) {
                                Get.find<MyPostsController>().apiPostLike(Get.find<MyPostsController>().myPosts[index]);
                              }else{
                                Get.find<MyPostsController>().apiPostUnlike(Get.find<MyPostsController>().myPosts[index]);
                              }
                            },
                            icon: Icon(
                              Get.find<MyPostsController>().myPosts[index].isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                              color: Get.find<MyPostsController>().myPosts[index].isLiked ? Colors.red : Colors.black,
                            ),
                            splashRadius: 20,
                          ),

                          //#commint
                          IconButton(
                            onPressed: (){},
                            icon: Image.asset('assets/images/chat.png', height: 28,),
                            splashRadius: 20,
                          ),

                          //#send
                          IconButton(
                            onPressed: (){},
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
                  child: Text(Get.find<MyPostsController>().myPosts[index].createdDate, style: const TextStyle(color: Colors.grey),)
              ),

              const SizedBox(height: 3,),

              Container(
                margin: const EdgeInsets.only(left: 20,),
                child: Text(Get.find<MyPostsController>().myPosts[index].caption, maxLines: 2, style: const TextStyle(fontSize: 16),),
              ),

            ],
          ),
        ),
        Get.find<MyPostsController>().isLiking() ? SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 260,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }

  void _bottomSheet(index) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 520,
            child: Column(
              children: [
                Container(
                    height: 450,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5,),

                        //Delete
                        InkWell(
                          onTap: (){
                            Get.find<MyPostsController>().removePost(Get.find<MyPostsController>().myPosts[index], context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Delete', style: TextStyle(fontSize: 17, color: Colors.red),),
                          ),
                        ),

                        const Divider(),

                        //Archive
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Archive', style: TextStyle(fontSize: 17),),
                          ),
                        ),

                        const Divider(),

                        //Hide
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Hide like count', style: TextStyle(fontSize: 17),),
                          ),
                        ),

                        const Divider(),

                        //TurnOf
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Turn off commenting', style: TextStyle(fontSize: 17),),
                          ),
                        ),

                        const Divider(),

                        //Edit
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Edit', style: TextStyle(fontSize: 17),),
                          ),
                        ),

                        const Divider(),

                        //CopyLink
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Copy link', style: TextStyle(fontSize: 17),),
                          ),
                        ),

                        const Divider(),

                        //ShareTo
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Share to', style: TextStyle(fontSize: 17),),
                          ),
                        ),

                        const Divider(),

                        //Share
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Share', style: TextStyle(fontSize: 17),),
                          ),
                        ),
                      ],
                    )
                ),

                const SizedBox(height: 10,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: const Text('Cancel', style: TextStyle(fontSize: 17, color: Colors.red),),
                    ),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
}
