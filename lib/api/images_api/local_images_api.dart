import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_placeholder_cache_image/api/dto/images_dto.dart';
import 'package:json_placeholder_cache_image/api/environment.dart';
import 'package:json_placeholder_cache_image/api/images_api/i_local_images_api.dart';
import 'package:json_placeholder_cache_image/api/mapper/images_mapper.dart';
import 'package:json_placeholder_cache_image/entity/image_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class LocalImagesApi implements ILocalImagesApi {
  LocalImagesApi({required this.dio});

  final Dio dio;

  static const String tableName = "cached_images";
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, Environment.dataBase);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName (localPath TEXT)');
      },
    );
  }

  Future<void> _clearOldFiles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    for (var map in maps) {
      final filePath = map['localPath'] as String;
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }

    await db.delete(tableName);
  }

  Future<ImageEntity> _downloadAndSaveImage(String url) async {
    if (url.isEmpty) throw Exception('Downloading went wrong');
    final directory = await getApplicationDocumentsDirectory();
    final fileName = Uri.parse(url).pathSegments.last;
    final filePath = join(directory.path, fileName);
    final file = File(filePath);

    if (!await file.exists()) {
      try {
        final response = await Dio()
            .get(url, options: Options(responseType: ResponseType.bytes));
        await file.writeAsBytes(response.data);
      } catch (e) {
        throw Exception('Failed to download image: $e');
      }
    }
    return ImagesMapper.mapPathToEntity(filePath);
  }

  @override
  Future<List<ImageEntity>> fetchImages() async {
    final db = await database;
    final maps = await db.query(tableName);

    return maps.map((map) => ImageEntity(
      path: map['localPath'].toString(),
    )).toList();
  }

  @override
  Future<void> saveImages(List<ImagesDto> urls) async {
    final db = await database;
    _clearOldFiles();
    for (var dto in urls) {
      final localPath = await _downloadAndSaveImage(dto.url!);
      await db.insert(
        tableName,
        {'localPath': localPath.path},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
