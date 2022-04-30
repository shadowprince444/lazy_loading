import 'package:pixabay_pagination_example/repository/pixabay_repo.dart';

///abstract class that defines the interface for [PixabayRepo]
abstract class IPixabayRepo {
  /// method to [lazy_load] images from #Pixabay api [imagesPerPage] defines images per request
  /// to be fetched,[searchTerm] is the term to be searched and [pageIndex] is the
  /// current page to be pulled.
  Future getImagesByPages(
    int imagesPerPage,
    String searchTerm, {
    int pageIndex = 1,
  }) async {}
}
