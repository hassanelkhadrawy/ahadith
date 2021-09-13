import 'package:ahadith/data/models/book.dart';
import 'package:ahadith/data/models/chapter.dart';
import 'package:ahadith/data/models/hadith.dart';
import 'package:ahadith/data/models/search.dart';
import 'package:ahadith/data/models/search_model.dart';
import 'package:ahadith/data/reprository/book_reprository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final BookRepository bookRepository;
  Book? books;
  Chapter?chapters;
  Hadith? hadith;
  SearchHadithModle? search_hadith;

  BooksCubit(this.bookRepository) : super(BooksInitial());

   getAllBooks() {
    bookRepository.getAllBooks().then((books) {
      emit(BooksLoaded(books));
      this.books = books;
    });
    return books;
  }

  getAllChapters(String bookId) {
    bookRepository.getAllChapters(bookId).then((chapters) {
      emit(ChaptersLoaded(chapters));
      this.chapters = chapters;
    });
    return chapters;
  }
  getAllChaptersHadiths(String bookId,String chapter_id) {
    bookRepository.getAllChaptersHadith(bookId,chapter_id).then((hadith) {
      emit(HadithsLoaded(hadith));
      this.hadith = hadith;
    });
    return hadith;
  }
  getAllSearchHadiths(String message) {
    bookRepository.getAllSearchHadith(message).then((search) {
      emit(SearchLoaded(search));
      this.search_hadith = search;
    });
    return search_hadith;
  }
}
