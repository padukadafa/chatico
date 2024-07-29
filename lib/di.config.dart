// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:awesome_notifications/awesome_notifications.dart' as _i1006;
import 'package:chatico/common/services/notification_service.dart' as _i289;
import 'package:chatico/core/router/app_router.dart' as _i427;
import 'package:chatico/data/data_sources/chat_remote_data_source.dart'
    as _i685;
import 'package:chatico/data/data_sources/db/notification_database.dart'
    as _i1050;
import 'package:chatico/data/data_sources/user_remote_data_source.dart'
    as _i587;
import 'package:chatico/di.dart' as _i98;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_database/firebase_database.dart' as _i345;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModul = _$RegisterModul();
    gh.factory<_i289.NotificationService>(() => _i289.NotificationService());
    gh.factory<_i974.FirebaseFirestore>(() => registerModul.firebaseFirestore);
    gh.factory<_i59.FirebaseAuth>(() => registerModul.firebaseAuth);
    gh.factory<_i457.FirebaseStorage>(() => registerModul.firebaseStorage);
    gh.factory<_i345.FirebaseDatabase>(() => registerModul.firebaseDatabase);
    gh.factory<_i892.FirebaseMessaging>(() => registerModul.firebaseMessaging);
    gh.factory<_i427.AppRouter>(() => registerModul.appRouter);
    gh.factory<_i1006.AwesomeNotifications>(
        () => registerModul.awesomeNotification);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModul.sharedPreferences,
      preResolve: true,
    );
    await gh.factoryAsync<_i1050.AppDatabase>(
      () => registerModul.appDatabase,
      preResolve: true,
    );
    gh.factory<_i685.ChatRemoteDataSource>(() => _i685.ChatRemoteDataSource());
    gh.factory<_i587.UserRemoteDataSource>(() => _i587.UserRemoteDataSource(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
          gh<_i892.FirebaseMessaging>(),
          gh<_i457.FirebaseStorage>(),
        ));
    return this;
  }
}

class _$RegisterModul extends _i98.RegisterModul {}
