import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_cache_image/repository/i_images_repository.dart';
import 'package:json_placeholder_cache_image/screens/images_screen/bloc/images_screen_state.dart';

class ImagesScreenCubit extends Cubit<ImagesScreenState> {
  ImagesScreenCubit({required this.imagesRepository})
      : super(ImagesScreenEmpty()) {
    loadImages();
  }

  final IImagesRepository imagesRepository;

  Future<void> loadImages() async {
    if (state is ImagesScreenLoading) return;

    try {
      emit(ImagesScreenLoading());
      final (images, isOffline) = await imagesRepository.getImages();
      if (images.isNotEmpty) {
        emit(ImagesScreenLoaded(images: images, isOffline: isOffline));
        return;
      }
      emit(ImagesScreenError(message: "Error: images not found, connection is missing"));
    } catch (e) {
      emit(
        ImagesScreenError(
          message:
              "Error: images not found, connection is missing",
        ),
      );
      log(e.toString());
    }
  }
}
