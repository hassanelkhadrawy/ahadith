part of 'books_cubit.dart';

@immutable
abstract class BooksState {}

class BooksInitial extends BooksState {}

class BooksLoaded extends BooksState {
  final Book? bookList;

  BooksLoaded(this.bookList);
}
class ChaptersLoaded extends BooksState{
   final Chapter? chapterList;

  ChaptersLoaded(this.chapterList);
}
class HadithsLoaded extends BooksState{
  final Hadith? hadithList;

  HadithsLoaded(this.hadithList);
}
class SearchLoaded extends BooksState{
  final SearchHadithModle? hadithList;

  SearchLoaded(this.hadithList);
}
