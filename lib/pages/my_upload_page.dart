import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_getx/controllers/my_upload_controller.dart';

class MyUploadPage extends StatefulWidget {
  MyUploadPage({Key? key, this.pageController}) : super(key: key);
  static const String id = 'my_upload_page';
  PageController? pageController;

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {

  @override
  Widget build(BuildContext context) {
    return GetX<MyUploadController>(
        init: MyUploadController(),
        builder: (_) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text("Upload", style: TextStyle(fontFamily: "Billabong", fontSize: 25, color: Colors.black),),
            centerTitle: true,
            actions: [

              IconButton(
                  onPressed: (){
                    Get.find<MyUploadController>().addPost(pageController: widget.pageController);
                  },
                  icon: const Icon(Icons.post_add, color: Color.fromRGBO(193, 53, 132, 1),)
              ),

            ],
          ),

          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [

                        // #image
                        InkWell(
                          onTap: () {
                            _bottomSheet();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.shade300,
                            child: Get.find<MyUploadController>().file().path.isNotEmpty ?
                            Stack(
                              children: [
                                Image.file(Get.find<MyUploadController>().file(),
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,),

                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.find<MyUploadController>().file().delete();
                                    },
                                    icon: const Icon(Icons.cancel_outlined, color: Colors.white,),
                                  ),
                                )
                              ],
                            )
                                : const Center(
                              child: Icon(Icons.add_a_photo, size: 60, color: Colors.grey,),
                            ),
                          ),
                        ),

                        // #caption
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                          child: TextField(
                            controller: Get.find<MyUploadController>().captionController(),
                            decoration: const InputDecoration(
                              hintText: "Caption",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            keyboardType: TextInputType.multiline,
                          ),
                        )
                      ],
                    ),
                    Get.find<MyUploadController>().isLoading() ? SizedBox(
                      height: MediaQuery.of(context).size.height - 250,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ) : const SizedBox.shrink(),
                  ],
                )
            ),
          ),

        )
    );
  }

  void _bottomSheet() {

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Column(
              children: [

                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Pick Photo"),
                  onTap: () {
                    Get.find<MyUploadController>().getImage(source: ImageSource.gallery, context: context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text("Take Photo"),
                  onTap: () {
                    Get.find<MyUploadController>().getImage(source: ImageSource.camera, context: context);
                  },
                ),

              ],
            ),
          );
        }
    );
  }

}
