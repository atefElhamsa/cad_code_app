import '../../domain/entities/course_folder_entity.dart';

class CourseFolderModel extends CourseFolderEntity {
  const CourseFolderModel({
    required super.id,
    required super.courseId,
    required super.title,
    super.description,
    super.imageUrl,
    super.createdAt,
  });

  factory CourseFolderModel.fromJson(Map<String, dynamic> json) {
    return CourseFolderModel(
      id: json['id'] as int,
      courseId: json['course_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'title': title,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }
}
