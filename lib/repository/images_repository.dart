import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:json_placeholder_cache_image/api/images_api/i_images_api.dart';
import 'package:json_placeholder_cache_image/api/images_api/i_local_images_api.dart';
import 'package:json_placeholder_cache_image/entity/image_entity.dart';
import 'package:json_placeholder_cache_image/repository/i_images_repository.dart';

class ImagesRepository implements IImagesRepository {
  ImagesRepository({
    required this.remoteImagesApi,
    required this.localImagesApi,
    required this.connectivity,
  });

  final IImagesApi remoteImagesApi;
  final ILocalImagesApi localImagesApi;
  final Connectivity connectivity;

  Future<bool> _isConnectionOn() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return (connectivityResult[0] != ConnectivityResult.none);
  }

  @override
  Future<(List<ImageEntity>, bool)> getImages() async {
    // для разных выводов добавляем случайное значение
    final page = Random().nextInt(50) + 5;
    const limit = 20;

    if (await _isConnectionOn()) {
      final imagesUrls = await remoteImagesApi.fetchImages(limit: limit, page: page);
      await localImagesApi.saveImages(imagesUrls);
      return (await localImagesApi.fetchImages(), false);
    } else {
      return (await localImagesApi.fetchImages(), true);
    }
  }
}
