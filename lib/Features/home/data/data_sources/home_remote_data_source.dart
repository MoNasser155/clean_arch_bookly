import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/utils/functions/save_books.dart';


abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiService.get(
      endPoint: 'volumes?q=programming&Filtering=free-ebooks',
    );
    
    List<BookEntity> books = getBooksList(
      data,
    );

    saveBooksData(books, kFeaturedBox);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiService.get(
      endPoint: 'volumes?q=Programming&Filtering=free-ebooks&Sorting=newest',
    );

    List<BookEntity> books = getBooksList(
      data,
    );

    saveBooksData(books, kNewestBox);
    return books;
  }

// helper function
// helper function
// helper function
// helper function
// helper function
// helper function
// helper function
// helper function
// helper function
// helper function
  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(
        BookModel.fromJson(
          bookMap,
        ),
      );
    }
    return books;
  }
}
