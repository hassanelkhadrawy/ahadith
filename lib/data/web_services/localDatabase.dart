import 'dart:convert';

import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/localDataModel.dart';
import 'package:ahadith/data/web_services/books_webservice.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataBase {
   Database? _db;

  late List<BookElement> list=[];

  Future<Database?> get db async {

    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');
    var myDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myDB;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Books (Book_ID INTEGER PRIMARY KEY UNIQUE, Book_Name TEXT )');
    await db.execute(
        'CREATE TABLE Chapters (Book_ID INTEGER ,Chapter_ID INTEGER , Chapter_Name TEXT )');
    await db.execute(
        'CREATE TABLE Hadeths (Book_ID INTEGER ,Chapter_ID INTEGER , Hadith_ID INTEGER,Ar_Text TEXT,Ar_Sanad_1 TEXT)');
    print("Tables Created");
  }

  Future<int> InsertBook(Map<String, dynamic> data) async {
    var db_client = await db;
    var insert = db_client!.insert("Books", data);


    return insert;
  }
   Future<int> InsertBookChapters(int BookId,List<ChapterElement>allChapters) async {
    List<HadithElemint> hadithElement;
    var result;
     var db_client = await db;
     Map<String,dynamic> data;
     for(int i=0;i<allChapters.length;i++){
       data={
         'Book_ID': BookId,
         'Chapter_ID': allChapters[i].chapterId,
         'Chapter_Name': allChapters[i].chapterName,
       };
       var insert = db_client!.insert("Chapters", data);
        // Hadith hadith=await BooksWebServices().getChaptersHadith(BookId.toString(), allChapters[i].chapterName);
        // hadithElement=hadith.chapter;
        // print(hadithElement.length);

        // for(int x=0 ;x<hadithElement.length;x++){
        //   data={
        //     'Book_ID': BookId,
        //     'Chapter_ID': allChapters[i].chapterId,
        //     'Hadith_ID': hadithElement[x].hadithId,
        //     'Ar_Text': hadithElement[x].arText,
        //     'Ar_Sanad_1': hadithElement[x].arSanad1,
        //   };
        //   db_client.insert("Hadeths", data);
        //
        // }
       result=insert;
     }
     return result;

   }
  Future<List<LocalBookModle>> GetData() async {
    var db_client = await db;
    var books = await db_client!.query("Books",orderBy: "Book_ID");
    return books.map((book) => LocalBookModle.fromJson(book)).toList();
  }
   Future<List<LocalChapterModle>> GetBookChapters(int id) async {
    print('id = $id');
     var db_client = await db;
     var chapters = await db_client!.query('Chapters');
     print(chapters.length);
     return chapters.map((book) => LocalChapterModle.fromJson(book)).toList();
   }

   Future<int> DeleteBook(int id) async {
     var db_client = await db;
     var result = await db_client!.rawDelete('DELETE FROM Books WHERE Book_ID = "$id"');
     return result;
   }

}
