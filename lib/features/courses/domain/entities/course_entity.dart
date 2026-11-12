import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final int id;
  final String title;
  final String tag;
  final String imageUrl;
  final String? description;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.tag,
    required this.imageUrl,
    this.description,
  });

  @override
  List<Object?> get props => [id, title, tag, imageUrl, description];
}
