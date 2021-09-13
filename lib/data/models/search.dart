// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  Search({
   required this.code,
   required this.hadithelement,
  });

  int code;
  List<SearchElement> hadithelement;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    code: json["code"],
    hadithelement: List<SearchElement>.from(json["Chapter"].map((x) => SearchElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "Chapter": List<dynamic>.from(hadithelement.map((x) => x.toJson())),
  };
}

class SearchElement {
  SearchElement({
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

  factory SearchElement.fromJson(Map<String, dynamic> json) => SearchElement(
    bookId: json["Book_ID"],
    chapterId: json["Chapter_ID"],
    hadithId: json["Hadith_ID"],
    arText: json["Ar_Text"],
    arSanad1: json["Ar_Sanad_1"],
  );

  Map<String, dynamic> toJson() => {
    "Book_ID": bookId,
    "Chapter_ID": chapterId,
    "Hadith_ID": hadithId,
    "Ar_Text": arText,
    "Ar_Sanad_1": arSanad1,
  };
}
