import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:instagram_clone_getx/services/http_service.dart';

class MySearchController extends GetxController{

  var searchController = TextEditingController().obs;
  var user = <Users>[].obs;
  var followingUsers = <Users>[].obs;
  var isLoading = false.obs;

  void apiSearchUsers(String keyword) async{
    isLoading.value = true;
    DataService.searchUsers(keyword).then((users) => _resSearchUser(users));
  }

  void _resSearchUser(List<Users> users) {
    isLoading.value = false;
    user.value = users;
  }

  void apiFollowUser(Users someone) async{

    Users me = await DataService.loadUser();
    isLoading.value = true;
    await DataService.followUser(someone);
    isLoading.value = false;
    await Network.POST(Network.API_PUSH, Network.bodyCreate(someone.deviceToken, me.userName)).then((value) {
      if (kDebugMode) {
        print(value);
      }
    });

    await DataService.storePostToMyFeeds(someone);
  }

  void apiUnFollowUser(Users someone) async{
    isLoading.value = true;
    await DataService.unFollowUser(someone);
    isLoading.value = false;
    await DataService.removePostFromMyFeeds(someone);
  }

  void getFollowingUsers() async{
    DataService.loadFollowedUsers().then((value) {
      followingUsers.value = value;
    });
    // _sortList();
  }

}