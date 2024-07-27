import 'package:floor/floor.dart';

@Entity(primaryKeys: ['id'], tableName: 'notifications')
class NotificationModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final String? body;
  final String? summary;
  final String? senderUid;
  final String? receiver;
  final String? target;
  final String? createdAt;
  final String? roomId;

  NotificationModel({
    this.id,
    this.title,
    this.createdAt,
    this.body,
    this.senderUid,
    this.receiver,
    this.summary,
    this.target,
    this.roomId,
  });
}
