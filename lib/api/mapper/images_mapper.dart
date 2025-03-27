import 'package:json_placeholder_cache_image/entity/image_entity.dart';

abstract class ImagesMapper {
  static ImageEntity mapPathToEntity(String path) {
    return ImageEntity(path: path);
  }
}
