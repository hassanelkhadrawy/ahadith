import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/id_model.dart';
import 'package:flutter/material.dart';

class ChapterItem extends StatelessWidget {
  final ChapterElement chapterElement;
  final int bookId;


  const ChapterItem(
      {Key? key, required this.bookId, required this.chapterElement})
      : super(key: key);

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
            onTap: () {
              IdModel idModel=IdModel(bookId, chapterElement.chapterId);
              Navigator.pushNamed(context, chapterHadithesScreen,
                  arguments: idModel);
            },
            child: GridTile(
              child: Hero(
                tag: chapterElement.chapterId,
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
                    child: Text(
                      chapterElement.chapterName,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
