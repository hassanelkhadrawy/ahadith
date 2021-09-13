
import 'dart:convert';

import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/search.dart';
import 'package:ahadith/data/models/search_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BooksWebServices{
  late Dio dio;
  late List<Book> books;


  BooksWebServices(){
    BaseOptions baseOptions=BaseOptions(
    baseUrl:baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio=Dio(baseOptions);
  }
  Future<Book> getAllBooks() async {

    Response response = await dio.get('books/ar');
    Book book=Book.fromJson(response.data);


    return book;
  }

  Future<Chapter> getAllChapters(String book_id) async {
    Response response = await dio.get('chapter/$book_id/ar');
    Chapter chapter=Chapter.fromJson(response.data);
    return chapter;
  }
  Future<Hadith> getChaptersHadith(String book_id,String chapter_id) async {
    Response response = await dio.get('ahadith/$book_id/$chapter_id/ar-tashkeel');
    Hadith hadith=Hadith.fromJson(response.data);
    return hadith;
  }
  Future<SearchHadithModle> getSearchHadith(String message) async {
    Response response = await dio.get('search/ahadith/$message/ar-tashkeel');
    SearchHadithModle hadith=SearchHadithModle.fromJson(response.data);
    return hadith;
  }

}