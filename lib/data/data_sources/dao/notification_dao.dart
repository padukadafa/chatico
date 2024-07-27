import 'package:chatico/data/models/notification.dart';
import 'package:floor/floor.dart';

@dao
abstract class NotificationDao {
  @Query('select * from notifications where receiver = :uid')
  Stream<List<NotificationModel>> getNotification(String uid);
  @insert
  Future<void> addNotification(NotificationModel notification);
}
