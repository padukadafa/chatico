import 'package:floor/floor.dart';

@Entity(primaryKeys: ['id'], tableName: 'notifications')
class NotificationModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final String? body;
  final String? summary;
  final String? senderUid;
  final String? senderName;
  final String? receiver;
  final String? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.createdAt,
    this.body,
    this.senderName,
    this.senderUid,
    this.receiver,
    this.summary,
  });
}
