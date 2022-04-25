import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:instagram_clone_getx/pages/edit_profile_page.dart';
import 'package:instagram_clone_getx/pages/home_page.dart';
import 'package:instagram_clone_getx/pages/my_feed_page.dart';
import 'package:instagram_clone_getx/pages/my_likes_page.dart';
import 'package:instagram_clone_getx/pages/my_posts_page.dart';
import 'package:instagram_clone_getx/pages/my_profile_page.dart';
import 'package:instagram_clone_getx/pages/my_search_page.dart';
import 'package:instagram_clone_getx/pages/my_upload_page.dart';
import 'package:instagram_clone_getx/pages/other_profile_page.dart';
import 'package:instagram_clone_getx/pages/settings_page.dart';
import 'package:instagram_clone_getx/pages/sign_in_page.dart';
import 'package:instagram_clone_getx/pages/sign_up_page.dart';
import 'package:instagram_clone_getx/pages/splash_page.dart';
import 'package:instagram_clone_getx/services/di_service.dart';
import 'package:instagram_clone_getx/services/hive_service.dart';

void main() async{
  await DIService.init();
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  var initAndroidSetting =
  const AndroidInitializationSettings("@mipmap/ic_launcher");
  var initIosSetting = const IOSInitializationSettings();
  var initSetting =
  InitializationSettings(android: initAndroidSetting, iOS: initIosSetting);
  await FlutterLocalNotificationsPlugin().initialize(initSetting);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _startPage() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            HiveDB.store(snapshot.data!.uid);
            return const SplashPage();
          } else {
            HiveDB.remove();
            return const SignInPage();
          }
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      getPages: [
          GetPage(name: '/home_page', page: () => const HomePage()),
          GetPage(name: '/sign_in_page', page: () => const SignInPage()),
          GetPage(name: '/sign_up_page', page: () => const SignUpPage()),
          GetPage(name: '/edit_profile_page', page: () => EditProfilePage()),
          GetPage(name: '/my_feed_page', page: () => MyFeedPage()),
          GetPage(name: '/my_likes_page', page: () => const MyLikesPage()),
          GetPage(name: '/my_posts_page', page: () => const MyPostsPage()),
          GetPage(name: '/my_profile_page', page: () => const MyProfilePage()),
          GetPage(name: '/my_search_page', page: () => MySearchPage()),
          GetPage(name: '/my_upload_page', page: () => MyUploadPage()),
          GetPage(name: '/other_profile_page', page: () => OtherProfilePage()),
          GetPage(name: '/settings_page', page: () => const SettingsPage()),
          GetPage(name: '/splash_page', page: () => const SplashPage()),
      ],
    );
  }
}