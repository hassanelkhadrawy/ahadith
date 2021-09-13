import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/id_model.dart';
import 'package:flutter/material.dart';

class HadithItem extends StatelessWidget {
  final HadithElemint hadithElemint;

  const HadithItem({Key? key, required this.hadithElemint}) : super(key: key);

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
              hadithDataModle dataModle = hadithDataModle(
                  hadithElemint.hadithId,
                  hadithElemint.arText,
                  hadithElemint.arSanad1);
              Navigator.pushNamed(context, hadithDetailsScreen,
                  arguments: dataModle);
            },
            child: GridTile(
              child: Hero(
                tag: hadithElemint.hadithId,
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
                    child: Column(
                      children: [
                        Text(
                          hadithElemint.arSanad1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 16,
                            color: MyColors.myNebety,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          hadithElemint.arText,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
