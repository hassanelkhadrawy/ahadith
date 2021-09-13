// To parse this JSON data, do
//
//     final hadith = hadithFromJson(jsonString);

import 'dart:convert';

Hadith hadithFromJson(String str) => Hadith.fromJson(json.decode(str));

String hadithToJson(Hadith data) => json.encode(data.toJson());

class Hadith {
  Hadith({
    required this.code,
    required this.chapter,
  });

  int code;
  List<HadithElemint> chapter;

  factory Hadith.fromJson(Map<String, dynamic> json) => Hadith(
    code: json["code"],
    chapter: List<HadithElemint>.from(json["Chapter"].map((x) => HadithElemint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "Chapter": List<dynamic>.from(chapter.map((x) => x.toJson())),
  };
}

class HadithElemint {
  HadithElemint({
    // required this.bookId,
    // required this.chapterId,
    required this.hadithId,
    required this.arText,
    required this.arSanad1,
  });
  // int bookId;
  // int chapterId;
  int hadithId;
  String arText;
  String arSanad1;

  factory HadithElemint.fromJson(Map<String, dynamic> json) => HadithElemint(
    // bookId: json["Book_ID"],
    // chapterId: json["Chapter_ID"],
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
