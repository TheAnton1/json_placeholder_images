import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_cache_image/screens/images_screen/bloc/images_screen_cubit.dart';
import 'package:json_placeholder_cache_image/screens/images_screen/images_screen.dart';
import 'package:json_placeholder_cache_image/sl.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON placeholder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => sl.sl<ImagesScreenCubit>(),
        child: const ImagesScreen(),
      ),
    );
  }
}
