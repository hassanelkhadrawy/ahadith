import 'package:ahadith/busniss_logic/cubit/books_cubit.dart';
import 'package:ahadith/constants/colors.dart';
import 'package:ahadith/constants/constant_wedgits.dart';
import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/localDataModel.dart';
import 'package:ahadith/data/models/search.dart';
import 'package:ahadith/data/models/search_model.dart';
import 'package:ahadith/data/web_services/localDatabase.dart';
import 'package:ahadith/presention/screens/download_screen.dart';
import 'package:ahadith/presention/widgets/Search_item.dart';
import 'package:ahadith/presention/widgets/book_item.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  late List<BookElement>? allBooks;
  List<SearchHadithElemint>? searchList;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final _searchTextController = TextEditingController();
  bool _isSearching = false;
  List<LocalBookModle>? bookList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      BlocProvider.of<BooksCubit>(context).getAllBooks();
      LocalDataBase().db;
      getDownloadBooks();
    }

  }

  Future<void> getDownloadBooks() async {
    var bookList1 = await LocalDataBase().GetData();

    setState((){
      bookList=bookList1;
      bookList!.sort((txn1, txn2) => txn2.bookID.compareTo(txn1.bookID));
    });

  }

  buildPagesSelected() {
    switch (_page) {
      case 0:
        return buildBlocWidget();
      case 1:
        return testAppBar();
      case 2:
        return DownloadScreen(bookList!);
    }
  }

  Widget buildBlocWidget() {
    getDownloadBooks();
    BlocProvider.of<BooksCubit>(context).getAllBooks();
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoaded) {
          allBooks = (state).bookList!.books;
          return buildLoadedListWidgets();
        } else {
          return ConstantsWedgits().showLoadingIndicator();
        }
      },
    );
  }


  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
          color: MyColors.myWhite,
          child: Container(
            child: Column(
              children: [buildImageSliderList(), buildBooksList()],
            ),
          )),
    );
  }

  Widget buildImageSliderList() {
    return ImageSlideshow(
      width: double.infinity,
      height: 300,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      children: [
        Image.asset(
          'assets/images/img_1.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/img_2.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/img_3.jpg',
          fit: BoxFit.cover,
        ),
      ],

      /// Called whenever the page in the center of the viewport changes.
      onPageChanged: (value) {
        print('Page changed: $value');
      },

      /// Auto scroll interval.
      /// Do not auto scroll with null or 0.
      autoPlayInterval: 3000,
    );
  }

  Widget buildBooksList() {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: allBooks!.length,
        itemBuilder: (ctx, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: ScaleAnimation(
                child: BookItem(
                  book: allBooks![index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget testAppBar() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: _isSearching
            ? BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: addSearchedFOrItemsToSearchedList(),
    );
  }

  Widget addSearchedFOrItemsToSearchedList() {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          searchList = (state).hadithList!.chapter;
          return buildSearchList();
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildSearchList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchList!.length,
      itemBuilder: (ctx, index) {
        return SearchItem(searchElement: searchList![index]);
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myNebety,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myWhite, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myWhite, fontSize: 18),
      onChanged: (searchText) async {
        // _searchTextController.text=searchText;
        await BlocProvider.of<BooksCubit>(context)
            .getAllSearchHadiths(searchText);
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Search',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            //Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
      searchList!.clear();
      buildBlocWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: MyColors.myNebety,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.search, size: 20),
          Icon(Icons.download, size: 20),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: buildPagesSelected(),
    );
  }
}
