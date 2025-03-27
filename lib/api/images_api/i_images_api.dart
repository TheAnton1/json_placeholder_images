import 'package:json_placeholder_cache_image/api/dto/images_dto.dart';

abstract class IImagesApi {
  Future<List<ImagesDto>> fetchImages({int? limit, int? page});
}