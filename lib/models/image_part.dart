import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'image_part.g.dart';

@JsonSerializable(converters: [Uint8ListConverter()])
class ImagePart {
  ImageType type;
  int index;
  int total;
  Uint8List? data;

  ImagePart({
    required this.type,
    required this.index,
    required this.total,
    required this.data,
  });

  factory ImagePart.fromJson(Map<String, dynamic> json) =>
      _$ImagePartFromJson(json);
  Map<String, dynamic> toJson() => _$ImagePartToJson(this);
}

enum ImageType { public, private }

class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  /// Create a new instance of [Uint8ListConverter].
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    if (json == null) return null;

    return Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    if (object == null) return null;
    return object.toList();
  }
}
