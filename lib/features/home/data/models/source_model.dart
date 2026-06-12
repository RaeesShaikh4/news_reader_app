import 'package:news_reader_app/features/home/domain/entities/source_entity.dart';

class SourceModel {
  final String id;
  final String name;

  const SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as String,
      name: json['name'] as String
    );
  }

  SourceEntity toEntity() => SourceEntity(
    id: id,
    name: name
  );
}