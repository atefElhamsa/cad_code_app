import '../../domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  SessionModel({
    required super.id,
    required super.folderId,
    required super.title,
    super.duration,
    required super.driveUrl,
    super.orderIndex,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as int,
      folderId: json['folder_id'] as int,
      title: json['title'] as String,
      duration: json['duration'] as String?,
      driveUrl: json['drive_url'] as String,
      orderIndex: json['order_index'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'folder_id': folderId,
      'title': title,
      'duration': duration,
      'drive_url': driveUrl,
      'order_index': orderIndex,
    };
  }
}
