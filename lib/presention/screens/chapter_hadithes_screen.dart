import 'package:ahadith/busniss_logic/cubit/books_cubit.dart';
import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/constant_wedgits.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/presention/widgets/hadith_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChapterHadithScreen extends StatefulWidget {
  final int book_Id;
  final int chapter_Id;

  const ChapterHadithScreen({Key? key,required this.book_Id,required this.chapter_Id}) : super(key: key);

  @override
  _ChapterHadithScreenState createState() => _ChapterHadithScreenState();
}

class _ChapterHadithScreenState extends State<ChapterHadithScreen> {

  List<HadithElemint>? allHadithes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BooksCubit>(context)
        .getAllChaptersHadiths(widget.book_Id.toString(),widget.chapter_Id.toString());
  }
  buildBlocWidget(){
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is HadithsLoaded) {
          allHadithes = (state).hadithList!.chapter;
          return buildChaptersList();
        } else {
          return ConstantsWedgits().showLoadingIndicator();
        }
      },
    );
  }
  Widget buildChaptersList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allHadithes!.length,
      itemBuilder: (ctx, index) {
        return HadithItem(hadithElemint: allHadithes![index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        title: Text(
          'Ahadith',
          style: TextStyle(fontSize: 18, color: MyColors.myWhite),
        ),
        backgroundColor: MyColors.myNebety,
      ),
      body: buildBlocWidget(),
    );
  }
}
