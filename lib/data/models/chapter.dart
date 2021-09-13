// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

Chapter chapterFromJson(String str) => Chapter.fromJson(json.decode(str));

String chapterToJson(Chapter data) => json.encode(data.toJson());

class Chapter {
  Chapter({
    required this.code,
    required this.chapter,
  });

  int code;
  List<ChapterElement> chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        code: json["code"],
        chapter: List<ChapterElement>.from(
            json["Chapter"].map((x) => ChapterElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "Chapter": List<dynamic>.from(chapter.map((x) => x.toJson())),
      };
}

class ChapterElement {
  ChapterElement({
    required this.chapterId,
    required this.chapterName,
  });

  int chapterId;
  String chapterName;

  factory ChapterElement.fromJson(Map<String, dynamic> json) => ChapterElement(
        chapterId: json["Chapter_ID"],
        chapterName: json["Chapter_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Chapter_ID": chapterId,
        "Chapter_Name": chapterName,
      };
}
