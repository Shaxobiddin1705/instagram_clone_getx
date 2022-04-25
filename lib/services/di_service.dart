import 'package:get/get.dart';
import 'package:instagram_clone_getx/controllers/edit_profile_controller.dart';
import 'package:instagram_clone_getx/controllers/home_controller.dart';
import 'package:instagram_clone_getx/controllers/my_feed_controller.dart';
import 'package:instagram_clone_getx/controllers/my_likes_controller.dart';
import 'package:instagram_clone_getx/controllers/my_posts_controller.dart';
import 'package:instagram_clone_getx/controllers/my_profile_controller.dart';
import 'package:instagram_clone_getx/controllers/my_serach_controller.dart';
import 'package:instagram_clone_getx/controllers/my_upload_controller.dart';
import 'package:instagram_clone_getx/controllers/other_profile_controller.dart';
import 'package:instagram_clone_getx/controllers/sign_in_controller.dart';
import 'package:instagram_clone_getx/controllers/sign_up_controller.dart';
import 'package:instagram_clone_getx/controllers/splash_controller.dart';

class DIService{

  static Future<void> init() async{
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SignInController>(() => SignInController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<MyFeedController>(() => MyFeedController(), fenix: true);
    Get.lazyPut<MyLikesController>(() => MyLikesController(), fenix: true);
    Get.lazyPut<MySearchController>(() => MySearchController(), fenix: true);
    Get.lazyPut<MyUploadController>(() => MyUploadController(), fenix: true);
    Get.lazyPut<MyProfileController>(() => MyProfileController(), fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(), fenix: true);
    Get.lazyPut<MyPostsController>(() => MyPostsController(), fenix: true);
    Get.lazyPut<OtherProfileController>(() => OtherProfileController(), fenix: true);
  }

}