import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:json_placeholder_cache_image/api/dto/images_dto.dart';
import 'package:json_placeholder_cache_image/api/images_api/i_images_api.dart';
import 'package:json_placeholder_cache_image/api/urls.dart';

class ImagesApi implements IImagesApi {
  ImagesApi({required this.dio});

  final Dio dio;

  @override
  Future<List<ImagesDto>> fetchImages({int? limit, int? page}) async {
    try {
      final response =
          await dio.get(Urls.jsonPlaceholderPhotos(limit!, page!));
      // минимальная обработка ошибок
      if (response.statusCode == 200) {
        final data = (response.data as List)
            .map((e) => ImagesDto.fromJson(e))
            .toList();
        return data;
      }
      throw Exception('Failed to load images from remote');
    } catch (e) {
      throw Exception('Failed to fetch images: $e');
    }
  }
}
