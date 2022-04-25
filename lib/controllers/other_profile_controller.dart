import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/models/post_model.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:instagram_clone_getx/services/http_service.dart';

class OtherProfileController extends GetxController{

  var pageController = PageController().obs;
  var currentTap = 0.obs;
  var isLoading = false.obs;
  var isFollowing = false.obs;
  var users = Users(fullName: '', email: '', password: '', userName: '').obs;
  List listPosts = <Posts>[].obs;

  loadPosts(user) {
    isLoading.value = true;
    DataService.loadOtherPost(user).then((value) {
      listPosts = value;
      if (kDebugMode) {
        print(value);
      }
    });
    isLoading.value = false;
  }

  void apiFollowUser(Users someone) async{
    isFollowing.value = true;
    await DataService.followUser(someone);
    isFollowing.value = false;
    await Network.POST(Network.API_PUSH, Network.bodyCreate(someone.deviceToken, someone.userName)).then((value) {
      if (kDebugMode) {
        print(value);
      }
    });

    await DataService.storePostToMyFeeds(someone);
  }

  void apiUnFollowUser(Users someone) async{
    isFollowing.value = true;
    await DataService.unFollowUser(someone);
    isFollowing.value = false;
    await DataService.removePostFromMyFeeds(someone);
  }

}