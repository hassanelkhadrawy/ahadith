import 'package:ahadith/constants/constant_wedgits.dart';
import 'package:ahadith/constants/constant_wedgits.dart';
import 'package:ahadith/data/models/localDataModel.dart';
import 'package:ahadith/data/web_services/localDatabase.dart';
import 'package:ahadith/presention/widgets/local_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadScreen extends StatefulWidget {
  late List<LocalBookModle> bookList;
  DownloadScreen(this.bookList);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  getDownloadBooks() async {

    var bookList1 = await LocalDataBase().GetData();
    widget.bookList=bookList1;


  }

  Widget buildList() {
    getDownloadBooks();
      return ListView.builder(
        itemCount: widget.bookList.length,
        itemBuilder: (_, int position) {
          //get your item data here ...
          return LocalBookItem(book: widget.bookList[position]);
        },
      );


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(mounted){
        LocalDataBase().db;
        getDownloadBooks();
      }

    });
    //BlocProvider.of<DownloadBookCubit>(context).getLocalBooks();

    //buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Downloads"),
        ),
        body: buildList());
  }
}
