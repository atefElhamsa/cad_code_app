import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final int id;
  final String title;
  final String tag;
  final String imageUrl;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.tag,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, tag, imageUrl];
}
