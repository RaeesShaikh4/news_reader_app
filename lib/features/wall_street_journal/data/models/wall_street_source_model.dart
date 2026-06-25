import 'package:news_reader_app/features/home/domain/entities/source_entity.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_source_entity.dart';

class WallStreetSourceModel {
  final String id;
  final String name;

  const WallStreetSourceModel({required this.id, required this.name});

  factory WallStreetSourceModel.fromJson(Map<String, dynamic> json) {
    return WallStreetSourceModel(
        id: json['id'] as String, name: json['name'] as String);
  }

  WallStreetSourceEntity toEntity() =>
      WallStreetSourceEntity(id: id, name: name);
}
