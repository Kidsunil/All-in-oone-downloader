import 'package:all_in_one_downloader/pages/facebook.dart';
import 'package:all_in_one_downloader/pages/homepage.dart';
import 'package:all_in_one_downloader/pages/tktok.dart';
import 'package:all_in_one_downloader/pages/yt.dart';
import 'package:all_in_one_downloader/themes/themedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'pages/insta_reels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  runApp(VxState(store: SylasStore(), child: const AllInOneDownloader()));
}

class SylasStore extends VxStore {}

bool darkMode = false;

class AllInOneDownloader extends StatefulWidget {
  const AllInOneDownloader({Key? key}) : super(key: key);

  @override
  State<AllInOneDownloader> createState() => _AllInOneDownloaderState();
}

class _AllInOneDownloaderState extends State<AllInOneDownloader> {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [ThemeMutation]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: context.cardColor,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark));
    return GetMaterialApp(
      theme: darkMode ? MyAppThemes.darkTheme() : MyAppThemes.lightTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/homePage',
      getPages: [
        GetPage(
          name: '/homePage',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/insta',
          page: () => const InstaGramReelsDownloaderPage(),
          transition: Transition.zoom,
          preventDuplicates: true,
          transitionDuration: 300.milliseconds,
        ),
        GetPage(
          name: '/yt',
          page: () => const YoutubeVideoDownloaderPage(),
          transition: Transition.zoom,
          preventDuplicates: true,
          transitionDuration: 300.milliseconds,
        ),
        GetPage(
          name: '/faceBook',
          page: () => const FacebookVideoDownloaderPage(),
          transition: Transition.zoom,
          preventDuplicates: true,
          transitionDuration: 300.milliseconds,
        ),
        GetPage(
          name: '/tikTok',
          page: () => const TiktokVideoDownloaderPage(),
          transition: Transition.zoom,
          preventDuplicates: true,
          transitionDuration: 300.milliseconds,
        ),
      ],
    );
  }
}

class ThemeMutation extends VxMutation {
  @override
  perform() async {
    final SharedPreferences darkTheme = await SharedPreferences.getInstance();
    if (!darkMode) {
      darkTheme.setBool("darkMode", false);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark));
    } else {
      darkTheme.setBool("darkMode", true);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.grey.shade800,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light));
    }
  }
}
