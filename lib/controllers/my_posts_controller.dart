import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/models/post_model.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';

class MyPostsController extends GetxController{

  var isLoading = false.obs;
  var isLiking = false.obs;
  List myPosts = <Posts>[].obs;
  var users = Users(fullName: '', email: '', password: '', userName: '').obs;

  apiPostLike(Posts post) async{
    isLiking.value = true;
    await DataService.likePost(post, true);
    isLiking.value = false;
    post.isLiked = true;
  }

  apiPostUnlike(Posts post) async{
    isLiking.value = true;
    await DataService.likePost(post, false);
    isLiking.value = false;
    post.isLiked = false;
  }

  void loadPosts() async{
    isLoading.value = true;
    DataService.loadPost().then((items) {
      _showResponse(items);
    });
  }

  _showResponse(List<Posts> items) {
    myPosts = items;
    isLoading.value = false;
  }

  removePost(Posts post, context) async{
    isLoading.value = true;
    DataService.removePost(post).then((value) {
      Navigator.pop(context);
      loadPosts();
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
    isLoading.value = false;
  }

}