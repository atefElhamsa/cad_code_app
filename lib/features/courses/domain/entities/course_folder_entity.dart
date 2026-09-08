import 'package:equatable/equatable.dart';

class CourseFolderEntity extends Equatable {
  final int id;
  final int courseId;
  final String title;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;

  const CourseFolderEntity({
    required this.id,
    required this.courseId,
    required this.title,
    this.description,
    this.imageUrl,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, courseId, title, description, imageUrl, createdAt];
}
