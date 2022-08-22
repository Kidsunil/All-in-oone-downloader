import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:all_in_one_downloader/helpers/helper.dart';
import 'package:all_in_one_downloader/widgets/snackbar.dart';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

import '../main.dart';

class InstaGramReelsDownloaderPage extends StatefulWidget {
  const InstaGramReelsDownloaderPage({Key? key}) : super(key: key);

  @override
  State<InstaGramReelsDownloaderPage> createState() =>
      _InstaGramReelsDownloaderPageState();
}

class _InstaGramReelsDownloaderPageState
    extends State<InstaGramReelsDownloaderPage> {
  LinkHelper linkHelper = LinkHelper();
  TextEditingController linkController = TextEditingController();
  bool pressed = false;
  bool downloading = false;
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    linkController.clear();
    linkController.dispose();
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future<String?> _findLocalPath() async {
    String? downloadsPath;
    if (Platform.isAndroid) {
      try {
        downloadsPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        downloadsPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      downloadsPath = (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return downloadsPath;
  }

  Future _download() async {
    var url = await linkHelper.downloadReels(linkController.text);
    final status = await Permission.storage.request();
    if (status.isGranted) {
      print(url);
      final path = await _findLocalPath();
      final id = await FlutterDownloader.enqueue(
        saveInPublicStorage: true,
        requiresStorageNotLow: false,
        url: url,
        savedDir: "$path",
        showNotification: true,
        openFileFromNotification: true,
      ).whenComplete(() {
        setState(() {
          downloading = false;
        });
      });
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Widget cancelButton = TextButton(
            child: Text(
              "CANCEL",
              style: TextStyle(
                  color: context.primaryColor, fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              Get.back();
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              "Allow Permission",
              style: TextStyle(
                  color: context.primaryColor, fontWeight: FontWeight.w700),
            ),
            onPressed: () async {
              await openAppSettings();
              Get.back();
            },
          );
          return Container(
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/attention.png",
                                height: 30, width: 30)
                            .px(6)
                            .centered(),
                        "ATTENTION!".text.bold.xl2.make().centered(),
                        Image.asset("assets/images/attention.png",
                                height: 30, width: 30)
                            .px(6)
                            .centered(),
                      ],
                    ),
                    Divider(thickness: 1, color: context.primaryColor),
                    const Text(
                      "You have permanently denied permission to access storage. Go to settings and enable the File and Storage Permissions to continue. Please allow permission to access storage to download the file.",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Flexible(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(flex: 100, child: cancelButton),
                            Flexible(flex: 200, child: continueButton),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else if (status.isDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Widget cancelButton = TextButton(
            child: Text(
              "CANCEL",
              style: TextStyle(
                  color: context.primaryColor, fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              Get.back();
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              "Allow Permission",
              style: TextStyle(
                  color: context.primaryColor, fontWeight: FontWeight.w700),
            ),
            onPressed: () async {
              await Permission.storage.request();
              Get.back();
            },
          );
          return Container(
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/attention.png",
                                height: 30, width: 30)
                            .px(6)
                            .centered(),
                        "ATTENTION!".text.bold.xl2.make().centered(),
                        Image.asset("assets/images/attention.png",
                                height: 30, width: 30)
                            .px(6)
                            .centered(),
                      ],
                    ),
                    Divider(thickness: 1, color: context.primaryColor),
                    const Text(
                      "You have denied permission to access storage. Please allow permission to access storage to download the file.",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Flexible(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(flex: 100, child: cancelButton),
                            Flexible(flex: 200, child: continueButton),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
          title:
              "Instagram Video Downloader".text.bold.maxLines(1).make().shimmer(
                    primaryColor: Colors.purple,
                    secondaryColor: Colors.blue,
                    duration: 6.seconds,
                  ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            15.heightBox,
            TextFormField(
              controller: linkController,
              decoration: InputDecoration(
                labelText: "Instagram Video/Reels Link",
                hintText: "Paste Instagram Video Link",
                labelStyle: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ).px(10).py(12),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.red,
              child: Ink(
                height: 38,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.primaryColor,
                ),
                child: "Start Download"
                    .text
                    .bold
                    .lg
                    .white
                    .align(TextAlign.center)
                    .make()
                    .centered(),
              ),
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await _download();
                if (LinkHelper.invalidUrl) {
                  ShowSnackBar.snackError(
                    "The Video can't be downloaded.",
                    "Currently the api only supports public channels and posts. Please check the link and try again.",
                  );
                }
              },
            ).px(10),
          ],
        ),
      ),
    );
  }
}

