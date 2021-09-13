import 'package:ahadith/busniss_logic/cubit/books_cubit.dart';
import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/constant_wedgits.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/presention/widgets/chapter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterScreen extends StatefulWidget {
  final int book_Id;

  const ChapterScreen({Key? key, required this.book_Id}) : super(key: key);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late List<ChapterElement>? allChapters;

  Widget buildBlocWidget() {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is ChaptersLoaded) {
          allChapters = (state).chapterList!.chapter;
          return buildChaptersList();
        } else {
          return ConstantsWedgits().showLoadingIndicator();
        }
      },
    );
  }

  Widget buildChaptersWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children: [
            ConstantsWedgits().showLoadingIndicator(),
            buildChaptersList()
          ],
        ),
      ),
    );
  }

  Widget buildChaptersList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allChapters!.length,
      itemBuilder: (ctx, index) {
        return ChapterItem(bookId: widget.book_Id,chapterElement: allChapters![index]);
      },
    );
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<BooksCubit>(context)
        .getAllChapters(widget.book_Id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        title: Text(
          'Chapters',
          style: TextStyle(fontSize: 18, color: MyColors.myWhite),
        ),
        backgroundColor: MyColors.myNebety,
      ),
      body: buildBlocWidget(),
    );
  }
}
