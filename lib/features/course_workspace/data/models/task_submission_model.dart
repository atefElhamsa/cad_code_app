class TaskSubmissionModel {
  final int id;
  final int taskId;
  final String studentId;
  final String fileUrl;
  final DateTime createdAt;

  TaskSubmissionModel({
    required this.id,
    required this.taskId,
    required this.studentId,
    required this.fileUrl,
    required this.createdAt,
  });

  factory TaskSubmissionModel.fromJson(Map<String, dynamic> json) {
    return TaskSubmissionModel(
      id: json['id'] as int,
      taskId: json['task_id'] as int,
      studentId: json['student_id'] as String,
      fileUrl: json['file_url'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
