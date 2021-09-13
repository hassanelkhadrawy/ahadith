class LocalBookModle{
 late int bookID;
  late String booName;

  LocalBookModle.fromJson(Map<String,dynamic> json){
    bookID=json["Book_ID"];
    booName=json["Book_Name"];
  }
}

class LocalChapterModle{
  late int book_Id;
  late int chapter_Id;
  late String chapter_Name;

  LocalChapterModle.fromJson(Map<String,dynamic> json){
    book_Id=json["Book_ID"];
    chapter_Id = json["Chapter_ID"];
    chapter_Name = json["Chapter_Name"];
  }
}