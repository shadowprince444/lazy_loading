import 'image_model.dart';

class PixabayImageResponseModel {
  PixabayImageResponseModel({
    required this.total,
    required this.totalHits,
    required this.hits,
  });
  late final int total;
  late final int totalHits;
  late final List<ImageModel> hits;

  PixabayImageResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalHits = json['totalHits'];
    hits = List.from(json['hits']).map((e) => ImageModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['totalHits'] = totalHits;
    _data['hits'] = hits.map((e) => e.toJson()).toList();
    return _data;
  }
}
