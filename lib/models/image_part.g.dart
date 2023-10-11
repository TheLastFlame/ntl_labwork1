// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagePart _$ImagePartFromJson(Map<String, dynamic> json) => ImagePart(
      type: $enumDecode(_$ImageTypeEnumMap, json['type']),
      index: json['index'] as int,
      total: json['total'] as int,
      data: const Uint8ListConverter().fromJson(json['data'] as List<int>?),
    );

Map<String, dynamic> _$ImagePartToJson(ImagePart instance) => <String, dynamic>{
      'type': _$ImageTypeEnumMap[instance.type]!,
      'index': instance.index,
      'total': instance.total,
      'data': const Uint8ListConverter().toJson(instance.data),
    };

const _$ImageTypeEnumMap = {
  ImageType.public: 'public',
  ImageType.private: 'private',
};
