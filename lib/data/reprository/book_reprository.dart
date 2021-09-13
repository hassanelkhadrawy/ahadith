import 'dart:convert';

import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/search.dart';
import 'package:ahadith/data/models/search_model.dart';
import 'package:ahadith/data/web_services/books_webservice.dart';

class BookRepository {
  final BooksWebServices booksWebServices;

  BookRepository(this.booksWebServices);

  Future<Book?> getAllBooks() async {
    Book books = await booksWebServices.getAllBooks();
    return books;
  }
  Future<Chapter?> getAllChapters(String book_id) async {
    Chapter chapters = await booksWebServices.getAllChapters(book_id);
    return chapters;
  }
  Future<Hadith?> getAllChaptersHadith(String book_id,String chapter_id) async {
    Hadith hadiths = await booksWebServices.getChaptersHadith(book_id,chapter_id);
    return hadiths;
  }
  Future<SearchHadithModle?> getAllSearchHadith(String message) async {
    SearchHadithModle hadiths = await booksWebServices.getSearchHadith(message);
    return hadiths;
  }
}
