// To parse this JSON data, do
//
//     final hadith = hadithFromJson(jsonString);

import 'dart:convert';

SearchHadithModle hadithFromJson(String str) => SearchHadithModle.fromJson(json.decode(str));

String hadithToJson(SearchHadithModle data) => json.encode(data.toJson());

class SearchHadithModle {
  SearchHadithModle({
    required this.code,
    required this.chapter,
  });

  int code;
  List<SearchHadithElemint> chapter;

  factory SearchHadithModle.fromJson(Map<String, dynamic> json) => SearchHadithModle(
    code: json["code"],
    chapter: List<SearchHadithElemint>.from(json["Chapter"].map((x) => SearchHadithElemint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "Chapter": List<dynamic>.from(chapter.map((x) => x.toJson())),
  };
}

class SearchHadithElemint {
  SearchHadithElemint({
    required this.bookId,
    required this.chapterId,
    required this.hadithId,
    required this.arText,
    required this.arSanad1,
  });
  int bookId;
  int chapterId;
  int hadithId;
  String arText;
  String arSanad1;

  factory SearchHadithElemint.fromJson(Map<String, dynamic> json) => SearchHadithElemint(
    bookId: json["Book_ID"],
    chapterId: json["Chapter_ID"],
    hadithId: json["Hadith_ID"],
    arText: json["Ar_Text"],
    arSanad1: json["Ar_Sanad_1"
    ],
  );

  Map<String, dynamic> toJson() => {
    "Hadith_ID": hadithId,
    "Ar_Text": arText,
    "Ar_Sanad_1": arSanad1,

  };
}
