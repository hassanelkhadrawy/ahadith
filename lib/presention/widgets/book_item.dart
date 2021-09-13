import 'package:ahadith/busniss_logic/cubit/books_cubit.dart';
import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/constant_wedgits.dart';
import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/localDataModel.dart';
import 'package:ahadith/data/web_services/books_webservice.dart';
import 'package:ahadith/data/web_services/localDatabase.dart';
import 'package:ahadith/presention/screens/books_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BookItem extends StatefulWidget {
  final BookElement book;

  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  late List<LocalBookModle>? bookList1;
  late LocalBookModle? bookModle1;
  late List<String>? list1 = [];
  late List<ChapterElement>? allChapters;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.myWhite,
        ),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, chapterScreen,
                arguments: widget.book.bookId),
            child: GridTile(
              child: Hero(
                tag: widget.book.bookId,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: MyColors.myNebety, width: 2),
                  ),
                  elevation: 10,
                  shadowColor: MyColors.myGrey,
                  margin: EdgeInsets.all(8.0),
                  color: MyColors.myWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.download_rounded,
                                color: MyColors.myNebety),
                            onPressed: () async {
                              bookList1 = await LocalDataBase().GetData();
                              for (int i = 0; i < bookList1!.length; i++) {
                                bookModle1 = bookList1![i];
                              }
                              print(list1);
                              if (list1!.contains(widget.book.bookName)) {
                                ConstantsWedgits()
                                    .SnakBar(context, "book exist");
                              } else {
                                LocalDataBase().InsertBook({
                                  'Book_ID': widget.book.bookId,
                                  'Book_Name': widget.book.bookName,
                                }).then((value) async {
                                  Chapter chapter = await BooksWebServices()
                                      .getAllChapters(
                                          widget.book.bookId.toString());
                                  allChapters = chapter.chapter;
                                  LocalDataBase().InsertBookChapters(widget.book.bookId,allChapters!).then((value){

                                    ConstantsWedgits().SnakBar(
                                        context, "book downloaded successfly"+allChapters!.length.toString());
                                  });

                                });
                              }
                            },
                          ),
                        ],
                      ),
                      title: Text(
                        widget.book.bookName,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
