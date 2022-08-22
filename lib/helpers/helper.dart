import 'dart:convert';
import 'dart:developer';
import 'package:all_in_one_downloader/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class LinkHelper {
  static bool invalidUrl = false;
  static String downloadLink = "";
  downloadReels(String url) async {
    var initialUrl = url.removeAllWhiteSpace().split("/");
    var response = await http.get(Uri.parse(
        '${initialUrl[0]}//${initialUrl[2]}/${initialUrl[3]}/${initialUrl[4]}/?__a=1'));
    log(response.body.toString());
    if (response.statusCode == 200 &&
        !response.body.contains("<!DOCTYPE html>")) {
      var data = json.decode(response.body);
      final finalUrl = data['graphql']['shortcode_media']['video_url'];
      downloadLink = finalUrl.toString();
    } else {
      invalidUrl = true;
    }
    print("efuytwegfhwevchgwvchgwev == === = = = = == = = =${downloadLink}");
    return downloadLink;
  }

  youtubeDownloaderApi(String a) async {
    var client = http.Client();
    var uri = Uri.parse('https://api.akuari.my.id/downloader/yt1?link=$a');
    var response = await client.get(
      uri,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var mp3 = data["mp3"];
      YoutubeVideoDetailsModelExtract.audioDetails
          .add(YoutubeVideoDetailsModel.fromMap(mp3));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
