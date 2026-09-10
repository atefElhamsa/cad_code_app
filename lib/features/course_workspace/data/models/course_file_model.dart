class CourseFileModel {
  final int id;
  final int folderId;
  final String title;
  final String driveUrl;
  final DateTime createdAt;

  CourseFileModel({
    required this.id,
    required this.folderId,
    required this.title,
    required this.driveUrl,
    required this.createdAt,
  });

  factory CourseFileModel.fromJson(Map<String, dynamic> json) {
    return CourseFileModel(
      id: json['id'] as int,
      folderId: json['folder_id'] as int,
      title: json['title'] as String,
      driveUrl: json['drive_url'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
