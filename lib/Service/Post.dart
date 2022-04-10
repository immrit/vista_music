import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.status,
    required this.data,
  });

  int status;
  List<Datum> data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.title,
    required this.artist,
    required this.url,
    required this.file,
    required this.cover,
  });

  String title;
  String artist;
  String url;
  String file;
  String cover;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        artist: json["artist"],
        url: json["url"],
        file: json["file"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "artist": artist,
        "url": url,
        "file": file,
        "cover": cover,
      };
}
