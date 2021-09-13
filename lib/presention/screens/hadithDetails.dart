import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/id_model.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HAdithDetails extends StatelessWidget {
  final hadithDataModle hadithElemint;

  const HAdithDetails({Key? key, required this.hadithElemint})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: DefaultTextStyle(
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myWhite,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText("اللَّهُ نُورُ السَّمَاوَاتِ وَالْأَرْضِ"),
            ],
          ),
        ),

        // Text(
        //   hadithElemint.arSanad1,
        //   textDirection: TextDirection.rtl,
        //   textAlign: TextAlign.center,
        //   overflow: TextOverflow.ellipsis,
        //   maxLines: 1,
        //   style: TextStyle(color: MyColors.myWhite),
        // ),
        background: Hero(
          tag: hadithElemint.hadith_id,
          child: Image.asset(
            'assets/images/hadith_image.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
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

                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        hadithElemint.arText,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 700,
              )
            ]),
          )
        ],

      ),
    );
  }
}
