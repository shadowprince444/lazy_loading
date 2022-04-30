import 'package:pixabay_pagination_example/interface/i_pixabay_repo.dart';
import 'package:pixabay_pagination_example/models/api_response_model.dart';
import 'package:pixabay_pagination_example/models/pixaby_response_model.dart';
import 'package:pixabay_pagination_example/services/dio_client.dart';

///concrete implementation for the [PixabayRepo] (repository)using the [IPixabayRepo] (interface) definition
class PixabayRepo implements IPixabayRepo {
  final _dioClient = DioClient();

  @override
  Future<ApiResponse<PixabayImageResponseModel>> getImagesByPages(int imagesPerPage, String searchTerm, {int pageIndex = 1}) async {
    try {
      final response = await _dioClient.request(uri: ApiUrls.baseUrl + queryBuilder(pageIndex, imagesPerPage, searchTerm), method: ApiMethod.get);
      return ApiResponse<PixabayImageResponseModel>.completed(PixabayImageResponseModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse<PixabayImageResponseModel>.error(e.toString());
    }
  }

  ///for building the query from [pageIndex],[itemsPerPage] and [searchTerm]
  String queryBuilder(int pageIndex, int itemsPerPage, String searchTerm) {
    return "&q=$searchTerm&per_page=$itemsPerPage&page=$pageIndex&image_type=photo";
  }
}
