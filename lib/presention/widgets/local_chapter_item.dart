import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/id_model.dart';
import 'package:ahadith/data/models/localDataModel.dart';
import 'package:flutter/material.dart';

class LocalChapterItem extends StatelessWidget {
  final LocalChapterModle chapterElement;


  const LocalChapterItem(
      {Key? key,  required this.chapterElement})
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

            },
            child: GridTile(
              child: Hero(
                tag: chapterElement.chapter_Id,
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
                      chapterElement. chapter_Name+"==>"+chapterElement.book_Id.toString() ,
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
