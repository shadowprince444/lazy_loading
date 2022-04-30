import 'image_model.dart';

/// response model from API
class PixabayImageResponseModel {
  PixabayImageResponseModel({
    required this.total,
    required this.totalHits,
    required this.hits,
  });
  late final int total;
  late final int totalHits;
  late final List<ImageModel> hits;

  ///[named_constructor] to convert [json] data to [PixabayImageResponseModel]
  PixabayImageResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalHits = json['totalHits'];
    hits = List.from(json['hits']).map((e) => ImageModel.fromJson(e)).toList();
  }

  ///converts [PixabayImageResponseModel] to [JSON] format(Map)
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['totalHits'] = totalHits;
    _data['hits'] = hits.map((e) => e.toJson()).toList();
    return _data;
  }
}
