import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:json_placeholder_cache_image/api/images_api/images_api.dart';
import 'package:json_placeholder_cache_image/api/images_api/local_images_api.dart';
import 'package:json_placeholder_cache_image/repository/images_repository.dart';
import 'package:json_placeholder_cache_image/screens/images_screen/bloc/images_screen_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
      () => ImagesScreenCubit(imagesRepository: sl<ImagesRepository>()));

  // Repos
  sl.registerLazySingleton(
    () => ImagesRepository(
      remoteImagesApi: sl<ImagesApi>(),
      localImagesApi: sl<LocalImagesApi>(),
      connectivity: sl<Connectivity>()
    ),
  );

  // API
  sl.registerLazySingleton(() => LocalImagesApi(dio: sl<Dio>()));
  sl.registerLazySingleton(() => ImagesApi(dio: sl<Dio>()));

  // Other
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
}
