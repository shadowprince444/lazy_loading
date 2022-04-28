abstract class IPixabayRepo {
  Future getImagesByPages(
    int imagesPerPage,
    String searchTerm, {
    int pageIndex = 1,
  }) async {}
}
