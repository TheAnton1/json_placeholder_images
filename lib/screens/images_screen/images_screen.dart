import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_cache_image/screens/images_screen/bloc/images_screen_cubit.dart';
import 'package:json_placeholder_cache_image/screens/images_screen/bloc/images_screen_state.dart';
import 'package:json_placeholder_cache_image/screens/images_screen/widgets/image_grid.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JSON Placeholder"),
        actions: [
          BlocBuilder<ImagesScreenCubit, ImagesScreenState>(
            builder: (context, state) {
              if (state is ImagesScreenLoaded && state.isOffline) {
                return const Row(
                  children: [
                    Text("No connection"),
                    SizedBox(width: 20),
                    Icon(Icons.wifi_off_rounded),
                    SizedBox(width: 16),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<ImagesScreenCubit, ImagesScreenState>(
        builder: (context, state) {
          if (state is ImagesScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ImagesScreenLoaded) {
            return ImageGrid(images: state.images);
          } else if (state is ImagesScreenError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No images available"));
          }
        },
      ),
    );
  }
}
