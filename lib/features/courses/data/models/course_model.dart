import 'package:cad_code_academy/features/courses/domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.title,
    required super.tag,
    required super.imageUrl,
    super.description,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'] ?? '',
      tag: json['tag'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tag': tag,
      'image_url': imageUrl,
      'description': description,
    };
  }
}
