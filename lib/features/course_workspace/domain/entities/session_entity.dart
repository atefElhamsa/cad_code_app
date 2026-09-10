class SessionEntity {
  final int id;
  final int folderId;
  final String title;
  final String? duration;
  final String driveUrl;
  final int? orderIndex;

  SessionEntity({
    required this.id,
    required this.folderId,
    required this.title,
    this.duration,
    required this.driveUrl,
    this.orderIndex,
  });
}
