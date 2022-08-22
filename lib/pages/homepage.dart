import 'package:all_in_one_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    "Instagram Video Downloader",
    "Facebook Video Downloader",
    "Youtube Video Downloader",
    "Tiktok Video Downloader",
  ];
  List<String> imageList = [
    "assets/images/insta.png",
    "assets/images/facebook.png",
    "assets/images/yt.png",
    "assets/images/tiktok.png",
  ];
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [ThemeMutation]);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: darkMode ? Colors.blue : Colors.black,
        backgroundColor:
            darkMode ? const Color.fromARGB(255, 34, 36, 47) : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        foregroundColor: Colors.blueAccent,
        surfaceTintColor: Colors.indigoAccent,
        title: "All In One Downloader".text.bold.maxLines(1).make().shimmer(
              primaryColor: Colors.purple,
              secondaryColor: Colors.blue,
              duration: 6.seconds,
            ),
        actions: [
          darkMode
              ? IconButton(
                  splashRadius: 10,
                  splashColor: Colors.green,
                  icon: const Icon(
                    Icons.light_mode_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      darkMode = !darkMode;
                      ThemeMutation();
                    });
                  },
                )
              : IconButton(
                  splashRadius: 10,
                  splashColor: Colors.green,
                  icon: const Icon(
                    Icons.dark_mode_outlined,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        darkMode = true;
                        ThemeMutation();
                      },
                    );
                  },
                ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (item) => onTapped(context, item),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 0,
                child: Text("Settings"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("About"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Help'),
              ),
              PopupMenuItem(
                value: 3,
                child: Text('Share'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 3,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 0.5,
                      ),
                      color: !darkMode
                          ? const Color(0xFFffffff)
                          : const Color.fromARGB(255, 34, 36, 47),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: GridTile(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            if (index == 0) {
                              Get.toNamed("/insta");
                            } else if (index == 1) {
                              Get.toNamed("/faceBook");
                            } else if (index == 2) {
                              Get.toNamed("/yt");
                            } else if (index == 3) {
                              Get.toNamed("/tikTok");
                            }
                          },
                          splashColor: Colors.greenAccent,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  imageList[index],
                                  fit: BoxFit.cover,
                                  height: 60,
                                ),
                                categories[index]
                                    .text
                                    .bold
                                    .center
                                    .scale(1)
                                    .maxLines(2)
                                    .make(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).p(12),
            ),
          ],
        )
            .box
            .color(!darkMode
                ? Colors.white
                : const Color.fromARGB(255, 34, 36, 47))
            .topRounded(value: 25)
            .make(),
      ),
    );
  }

  void onTapped(BuildContext context, int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        Share.share(
            'All In One Downloader is a simple and fast downloader for Android and iOS.\n\nDownload it now from:');
        break;
      default:
        Get.back();
        break;
    }
  }
}
