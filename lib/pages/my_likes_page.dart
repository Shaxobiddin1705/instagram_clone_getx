import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/my_likes_controller.dart';
import 'package:shimmer/shimmer.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);
  static const String id = 'my_likes_page';

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {

  @override
  void initState() {
    Get.find<MyLikesController>().apiLoadLikes();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        title: const Text('Activity', style: TextStyle(fontFamily: 'Billabong', fontSize: 26),),
      ),
      body: GetX<MyLikesController>(
        init: MyLikesController(),
        builder: (_) => Get.find<MyLikesController>().isLoading() ? SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 250,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ) : Get.find<MyLikesController>().posts.isNotEmpty ? ListView.builder(
            itemCount: Get.find<MyLikesController>().posts.length,
            itemBuilder: (context, index) {
              return _items(index);
            }
        ) : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 150,
          child: const Center(
            child: Text('No Liked posts', style: TextStyle(fontSize: 19),),
          ),
        ),
      )
    );
  }

  Widget _items(index){
    return ListTile(
      leading: Get.find<MyLikesController>().posts[index].imageUser == null ? const CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage('assets/images/person_icon.png'),
      ) : ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: CachedNetworkImage(
          height: 48,
          width: 48,
          imageUrl: Get.find<MyLikesController>().posts[index].imageUser!, fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 48,
              width: 48,
              color: Colors.grey[300],
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Row(
        children: [
          Text(Get.find<MyLikesController>().posts[index].userName, style: const TextStyle(fontWeight: FontWeight.w500),),
          const SizedBox(width: 5,),
          const Text('liked your'),
        ],
      ),
      subtitle: const Text('photo', style: TextStyle(color: Colors.black),),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          height: 50,
          width: 50,
          imageUrl: Get.find<MyLikesController>().posts[index].postImage, fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 50,
              width: 50,
              color: Colors.grey[300],
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
