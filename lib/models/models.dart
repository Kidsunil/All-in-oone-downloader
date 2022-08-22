// ignore_for_file: prefer_typing_uninitialized_variables

class YoutubeVideoDetailsModel {
  final title;
  final result;
  final size;
  final thumbb;
  final views;
  final likes;
  final dislike;
  final channel;
  final uploadDate;
  final desc;
  final quality;

  YoutubeVideoDetailsModel({
    this.title,
    this.result,
    this.size,
    this.thumbb,
    this.views,
    this.likes,
    this.dislike,
    this.channel,
    this.uploadDate,
    this.desc,
    this.quality,
  });

  factory YoutubeVideoDetailsModel.fromMap(Map<String, dynamic> map) {
    return YoutubeVideoDetailsModel(
      title: map["title"],
      result: map["result"],
      size: map["size"],
      thumbb: map["thumbb"],
      views: map["views"],
      likes: map["likes"],
      dislike: map["dislike"],
      channel: map["channel"],
      uploadDate: map["uploadDate"],
      desc: map["desc"],
      quality: map["quality"],
    );
  }

  Map<String, dynamic> toMap() => {
        "title": title,
        "result": result,
        "size": size,
        "thumbb": thumbb,
        "views": views,
        "likes": likes,
        "dislike": dislike,
        "channel": channel,
        "uploadDate": uploadDate,
        "desc": desc,
        "quality": quality,
      };
}

class YoutubeVideoDetailsModelExtract {
  static List<YoutubeVideoDetailsModel> videoDetails = [];
  static List<YoutubeVideoDetailsModel> audioDetails = [];
}
