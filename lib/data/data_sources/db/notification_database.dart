import 'dart:async';

import 'package:chatico/data/data_sources/dao/notification_dao.dart';
import 'package:chatico/data/models/notification.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'notification_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [NotificationModel])
abstract class AppDatabase extends FloorDatabase {
  NotificationDao get notificationDao;
}
