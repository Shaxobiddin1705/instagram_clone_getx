import 'package:get/get.dart';
import 'package:instagram_clone_getx/models/post_model.dart';
import 'package:instagram_clone_getx/services/data_service.dart';

class MyLikesController extends GetxController{

  var isLoading = false.obs;
  var posts = <Posts>[].obs;

  void apiLoadLikes(){
    isLoading.value = true;
    DataService.loadLikes().then((value) {
      _resLoadLikes(value);
    });
  }

  void _resLoadLikes(List<Posts> list) {
    posts.value = list;
    isLoading.value = false;
  }

}