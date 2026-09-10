class TaskModel {
  final int id;
  final int folderId;
  final String title;
  final String? description;
  final String driveUrl;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.folderId,
    required this.title,
    this.description,
    required this.driveUrl,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      folderId: json['folder_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      driveUrl: json['drive_url'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
