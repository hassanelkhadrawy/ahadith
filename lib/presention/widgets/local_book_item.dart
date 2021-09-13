import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/constant_wedgits.dart';
import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/localDataModel.dart';
import 'package:ahadith/data/web_services/localDatabase.dart';
import 'package:ahadith/presention/screens/books_screens.dart';
import 'package:ahadith/presention/screens/download_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalBookItem extends StatefulWidget {
  final LocalBookModle book;


  const LocalBookItem({Key? key, required this.book}) : super(key: key);

  @override
  _LocalBookItemState createState() => _LocalBookItemState();
}

class _LocalBookItemState extends State<LocalBookItem> {
  late List<LocalChapterModle> chaptersList;
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
            onTap: () async {
             chaptersList=await LocalDataBase().GetBookChapters(widget.book.bookID);
             setState(() {
               if(chaptersList.isEmpty){
                 ConstantsWedgits().showLoadingIndicator();
               }else{
                 Navigator.pushNamed(context, localChapters ,arguments: chaptersList);
                 // ConstantsWedgits().SnakBar(context, chaptersList.length.toString());

               }
             });
            },

            child: GridTile(
              child: Hero(
                tag: widget.book.bookID,
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
                            icon: Icon(Icons.delete_forever,
                                color: MyColors.myNebety),
                            onPressed: () async {
                              LocalDataBase()
                                  .DeleteBook(widget.book.bookID)
                                  .then(
                                (value) {
                                  if (value == 1) {
                                    ConstantsWedgits()
                                        .SnakBar(context, "Book Deleted");

                                  } else {
                                    ConstantsWedgits()
                                        .SnakBar(context, "Book Not Deleted");
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      title: Text(
                        widget.book.booName,
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
