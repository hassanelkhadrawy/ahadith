import 'package:ahadith/data/models/localDataModel.dart';
import 'package:ahadith/data/web_services/localDatabase.dart';
import 'package:ahadith/presention/widgets/local_chapter_item.dart';
import 'package:flutter/material.dart';
class LocalChapters extends StatefulWidget {

   final List<LocalChapterModle> chaptersList;

const LocalChapters({Key? key,required this.chaptersList}) : super(key: key);

  @override
  _LocalChaptersState createState() => _LocalChaptersState();
}


class _LocalChaptersState extends State<LocalChapters> {

  Widget buildChaptersList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.chaptersList.length,
      itemBuilder: (ctx, index) {
        return LocalChapterItem(chapterElement: widget.chaptersList[index]);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Downloaded Chapters"),
        ),
        body: buildChaptersList(),
      ),
    );
  }
}
