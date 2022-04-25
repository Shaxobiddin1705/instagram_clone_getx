import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/my_serach_controller.dart';
import 'package:instagram_clone_getx/pages/other_profile_page.dart';

class MySearchPage extends StatefulWidget {
  MySearchPage({Key? key, this.controller}) : super(key: key);
  static const String id = 'my_search_page';
  PageController? controller;

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {


  @override
  void initState(){
    super.initState();
    Get.find<MySearchController>().apiSearchUsers("");
    Get.find<MySearchController>().getFollowingUsers();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetX<MySearchController>(
            init: MySearchController(),
            builder: (_) => Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [

                      //#searchTextfield
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2)
                        ),
                        child: TextField(
                          controller: Get.find<MySearchController>().searchController(),
                          onChanged: (keyword) {
                            Get.find<MySearchController>().apiSearchUsers(keyword);
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey,),
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Get.find<MySearchController>().user.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OtherProfilePage(users: Get.find<MySearchController>().user[index])));
                                // widget.controller!.animateToPage(5, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                              },
                              leading: Container(
                                padding: const EdgeInsets.all(2),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(width: 1.5, color: const Color.fromRGBO(193, 53, 132, 1))
                                ),
                                child: Get.find<MySearchController>().user[index].imageUrl == null ?const CircleAvatar(
                                  radius: 22,
                                  backgroundImage: AssetImage('assets/images/person_icon.png'),
                                ) : ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                    imageUrl: Get.find<MySearchController>().user[index].imageUrl!,
                                    placeholder: (context, url) => const Image(image: AssetImage("assets/images/person_icon.png")),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              title: Text(Get.find<MySearchController>().user[index].userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Get.find<MySearchController>().user[index].fullName, style: const TextStyle(fontSize: 12, color: Colors.grey),),
                                  const Text("Following", style: TextStyle(fontSize: 12, color: Colors.grey),)
                                ],
                              ),
                              trailing: Container(
                                height: 26,
                                width: 95,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: MaterialButton(
                                  height: 26,
                                  onPressed: (){
                                    if(Get.find<MySearchController>().user[index].followed){
                                      Get.find<MySearchController>().apiUnFollowUser(Get.find<MySearchController>().user[index]);
                                    }else{
                                      Get.find<MySearchController>().apiFollowUser(Get.find<MySearchController>().user[index]);
                                    }
                                  },
                                  child: Text(Get.find<MySearchController>().user[index].followed ? 'Following' : 'Follow', style: const TextStyle(color: Colors.grey),),
                                ),
                              ),
                            );
                          }
                      ),

                    ],
                  ),
                ),
                Get.find<MySearchController>().isLoading() ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ) ) : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
