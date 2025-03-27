import 'package:json_annotation/json_annotation.dart';

part 'images_dto.g.dart';

@JsonSerializable()
class ImagesDto {
  ImagesDto({
    required this.url,
  });

  @JsonKey(name: 'download_url')
  final String? url;

  factory ImagesDto.fromJson(Map<String, dynamic> json) =>
      _$ImagesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesDtoToJson(this);
}
