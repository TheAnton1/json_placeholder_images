import 'package:json_placeholder_cache_image/api/dto/images_dto.dart';
import 'package:json_placeholder_cache_image/entity/image_entity.dart';

abstract class ILocalImagesApi {
  Future<void> saveImages(List<ImagesDto> urls);
  Future<List<ImageEntity>> fetchImages();
}