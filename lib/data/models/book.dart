// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  Book({
    required this.code,
    required this.books,
  });

  int code;
  List<BookElement> books;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    code: json["code"],
    books: List<BookElement>.from(json["Books"].map((x) => BookElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "Books": List<dynamic>.from(books.map((x) => x.toJson())),
  };
}

class BookElement {
  BookElement({
    required this.bookId,
    required this.bookName,
  });

 late int bookId;
 late String bookName;

  factory BookElement.fromJson(Map<String, dynamic> json) => BookElement(
    bookId: json["Book_ID"],
    bookName: json["Book_Name"],
  );

  Map<String, dynamic> toJson() => {
    "Book_ID": bookId,
    "Book_Name": bookName,
  };
}

class test{
  String? item;
  test(this.item);
}