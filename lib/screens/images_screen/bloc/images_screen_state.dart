import 'package:json_placeholder_cache_image/entity/image_entity.dart';

abstract class ImagesScreenState {}

class ImagesScreenEmpty implements ImagesScreenState {}

class ImagesScreenLoading implements ImagesScreenState {}

class ImagesScreenLoaded implements ImagesScreenState {
  ImagesScreenLoaded({required this.isOffline, required this.images});

  final List<ImageEntity> images;
  final bool isOffline;
}

class ImagesScreenError implements ImagesScreenState {
  ImagesScreenError({required this.message});

  final String message;
}
