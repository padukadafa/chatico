import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/data/data_sources/db/notification_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di.config.dart';

final getIt = GetIt.instance;
@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();

@module
abstract class RegisterModul {
  @injectable
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
  @injectable
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  @injectable
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
  @injectable
  FirebaseDatabase get firebaseDatabase => FirebaseDatabase.instance;
  @injectable
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  @injectable
  AppRouter get appRouter => AppRouter();
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @preResolve
  Future<AppDatabase> get appDatabase =>
      $FloorAppDatabase.databaseBuilder("app_database").build();
}
