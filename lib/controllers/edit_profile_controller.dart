import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:instagram_clone_getx/services/store_service.dart';

class EditProfileController extends GetxController{

  var users = Users(fullName: '', email: '', password: '', userName: '').obs;
  var file = File('').obs;
  var isLoading = false.obs;
  var fullNameController = TextEditingController().obs;
  var userNameController = TextEditingController().obs;
  var bioController = TextEditingController().obs;

  imgFromCamera(context) async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    file.value = File(image!.path);
    apiChangePhoto(context);
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    file.value = File(image!.path);
  }

  void apiChangePhoto(context) {
    isLoading.value = true;
    if(file().path.isNotEmpty) {
      StoreService.uploadImage(file(), StoreService.folderUserImage).then((value) => _apiUpdateUser(value!, context));
    }else{
      _apiUpdateUser('null', context);
    }
  }

  void _apiUpdateUser(String imgUrl, context) async {
    String fullName = fullNameController().text.trim().toString();
    String userName = userNameController().text.trim().toString();
    log(fullName);
    isLoading.value = false;
    if(imgUrl != 'null') users().imageUrl = imgUrl;
    users.value.userName = userName;
    users.value.fullName = fullName;
    log(users().fullName);
    DataService.updateUser(users.value).then((value) {
      Navigator.pop(context);
    });
  }


  void apiLoadUser() async {
    isLoading.value = true;
    DataService.loadUser().then((items) {
      _showUserInfo(items);
    });
  }

  void _showUserInfo(Users user) {
    users.value = user;
    _initialController();
    isLoading.value = false;
  }

  _initialController() {
    String fullName = users().fullName;
    String userName = users().userName;

    fullNameController.value = TextEditingController(text: fullName);
    userNameController.value = TextEditingController(text: userName);
  }

}