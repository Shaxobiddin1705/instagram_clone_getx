import 'package:get/get.dart';
import 'package:instagram_clone_getx/models/post_model.dart';
import 'package:instagram_clone_getx/models/user_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';
import 'package:share_plus/share_plus.dart';

class MyFeedController extends GetxController{

  var isLoading = false.obs;
  var onPressed = false.obs;
  var isLiking = false.obs;
  var posts = <Posts>[].obs;
  var users = Users(fullName: '', email: '', password: '', userName: '').obs;

  void loadPosts() async{
    isLoading.value = true;
    DataService.loadFeed().then((items) {
      _showResponse(items);
    });
  }

  _showResponse(List<Posts> items) {
    posts.value = items;
    isLoading.value = false;
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

  void share(int index) async{
    await Share.share(posts[index].postImage);
  }

}