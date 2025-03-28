import 'package:json_placeholder_cache_image/entity/image_entity.dart';

abstract class IImagesRepository {
  Future<(List<ImageEntity>, bool isOffline)> getImages();
}