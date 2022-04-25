import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_getx/models/post_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:instagram_clone_getx/services/store_service.dart';

class MyUploadController extends GetxController{

  var captionController = TextEditingController().obs;
  var file  =  File("").obs;
  var isLoading = false.obs;

  Future<void> getImage({required ImageSource source, required context}) async{
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(source: source);
    if(image != null) {
      file.value = File(image.path);
    }
  }

  void addPost({required pageController}) async{
    String caption = captionController().text.trim().toString();
    if(caption.isEmpty || file == null) return;
    _postImage(caption: caption, pageController: pageController);
  }

  _postImage({caption, pageController}) {
    late Posts post;
    isLoading.value = true;
    StoreService.uploadImage(file(), StoreService.folderPostImage).then((value) => {
      post = Posts(postImage: value!, caption: caption),
      DataService.storePost(post).then((value) {
        isLoading.value = false;
        _goFeedPage(post, pageController);
      }),
    });
  }

  void _goFeedPage(Posts post, pageController) async{
    DataService.storeFeed(post).then((value) {
      pageController!.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      file.value.delete();
      captionController().clear();
    });
  }

}