import 'package:ahadith/busniss_logic/cubit/books_cubit.dart';
import 'package:ahadith/constants/strings.dart';
import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/id_model.dart';
import 'package:ahadith/data/models/localDataModel.dart';
import 'package:ahadith/data/reprository/book_reprository.dart';
import 'package:ahadith/data/web_services/books_webservice.dart';
import 'package:ahadith/presention/screens/books_screens.dart';
import 'package:ahadith/presention/screens/chapter_hadithes_screen.dart';
import 'package:ahadith/presention/screens/chapters_screen.dart';
import 'package:ahadith/presention/screens/hadithDetails.dart';
import 'package:ahadith/presention/screens/local_chapters.dart';
import 'package:ahadith/presention/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRouter {
  late BookRepository bookRepository;
  late BooksCubit booksCubit;

  AppRouter() {
    bookRepository = BookRepository(BooksWebServices());
    booksCubit = BooksCubit(bookRepository);
  }

  Route? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case booksScreen:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (BuildContext context) => booksCubit,
                  child: BooksScreen(),
                ));
      case chapterScreen:
        final int bookId =
        settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (BuildContext context) => BooksCubit(bookRepository),
                  child: ChapterScreen(
                    book_Id: bookId,
                  ),
                ));
      case chapterHadithesScreen:
      case chapterScreen:
        final IdModel idModel =
        settings.arguments as IdModel;
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (BuildContext context) => BooksCubit(bookRepository),
                  child: ChapterHadithScreen(
                    book_Id: idModel.book_id, chapter_Id: idModel.chapter_id,
                  ),
                ));
      case hadithDetailsScreen:
        final hadithDataModle hadithElemint =
        settings.arguments as hadithDataModle;
        return MaterialPageRoute(
          builder: (_) =>
              HAdithDetails(hadithElemint: hadithElemint,),
        );
      case searchScreen:
        return MaterialPageRoute(
            builder: (_)=> BlocProvider(
                create: (BuildContext context)=> BooksCubit(bookRepository),
              child: SearchScreen(),
            ),
        );
      case localChapters:
        final List<LocalChapterModle> Chapterlist=settings.arguments as List<LocalChapterModle>;
        return MaterialPageRoute(
          builder: (_)=>  LocalChapters(chaptersList: Chapterlist),
        );

    }

  }
}
