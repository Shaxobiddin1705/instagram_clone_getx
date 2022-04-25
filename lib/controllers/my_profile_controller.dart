import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_getx/models/post_model.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:instagram_clone_getx/services/store_service.dart';

class MyProfileController extends GetxController{

  var pageController = PageController().obs;
  var currentTap = 0.obs;
  var file = File('').obs;
  var isLoading = false.obs;
  final users = Users(fullName: '', email: '', password: '', userName: '').obs;
  List listPosts = <Posts>[].obs;

  void loadPosts() {
    DataService.loadPost().then((value) {
      listPosts = value;
    });
  }

  imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    file.value = File(image!.path);
    _apiChangePhoto();
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    file.value = File(image!.path);
    _apiChangePhoto();
  }

  // for load user
  void apiLoadUser() async {
    isLoading.value = true;
    DataService.loadUser().then((Users items) {
      users.value = items;
      users.value.fullName = items.fullName;
      users.value.userName = items.userName;
      users.value.imageUrl = items.imageUrl;
      isLoading.value = false;
      // _showUserInfo(items);

    });
  }

  void _showUserInfo(Users user) {
    users.value = user;
    isLoading.value = false;
  }

  // for edit user
  void _apiChangePhoto() {
    if (file == null) return;

    isLoading.value = true;
    StoreService.uploadImage(file(), StoreService.folderUserImage).then((value) => _apiUpdateUser(value!));
  }

  void _apiUpdateUser(String imgUrl) async {
    isLoading.value = false;
    users().imageUrl = imgUrl;
    await DataService.updateUser(users());
  }

}