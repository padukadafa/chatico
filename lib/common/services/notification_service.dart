import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chatico/common/values/app_constants.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/presentation/pages/chat/chat_page.dart';
import 'package:chatico/presentation/pages/chat_list/chat_list_page.dart';
import 'package:chatico/presentation/pages/loading/loading_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class NotificationService {
  static requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("User granted permission");
      }
    }
    if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("User granted Provisional permission");
      }
    }
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      if (kDebugMode) {
        print("User declined or has not accepted permission");
      }
    }
  }

  static Future<void> initilizeNotifification() async {
    await requestPermission();

    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
            channelGroupKey: 'message_group',
            channelKey: 'message',
            channelName: 'Message ',
            channelDescription: 'This is Message',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
          ),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: 'message_group',
            channelGroupName: 'Message Group',
          )
        ],
        debug: true);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
    listenNotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma("vm:entry-point")
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    final title = message.notification!.title;
    final body = message.notification!.body;
    const String channel = "message";
    final summary = message.data['summary'];
    final roomId = message.data['roomId'];

    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: UniqueKey().hashCode,
          channelKey: channel,
          color: Colors.white,
          title: title,
          body: body,
          notificationLayout: NotificationLayout.MessagingGroup,
          wakeUpScreen: true,
          fullScreenIntent: true,
          summary: summary,
          groupKey: roomId,
          backgroundColor: Colors.blue,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'reply',
            label: "Reply",
          ),
        ]);
  }

  static Future<void> listenNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final title = message.notification!.title;
      final body = message.notification!.body;
      const String channel = "message";
      final summary = message.data['summary'];
      final roomId = message.data['roomId'];

      AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: UniqueKey().hashCode,
            channelKey: channel,
            color: Colors.white,
            title: title,
            body: body,
            notificationLayout: NotificationLayout.MessagingGroup,
            wakeUpScreen: true,
            fullScreenIntent: true,
            summary: summary,
            groupKey: roomId,
            backgroundColor: Colors.blue,
          ),
          actionButtons: [
            NotificationActionButton(
              key: 'reply',
              label: "Reply",
            ),
          ]);
    });
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final chatRoom =
        await ChatRemoteDataSource().getChatRoomById(receivedAction.groupKey!);
    if (chatRoom != null) {
      GetIt.I<AppRouter>().replaceAll([
        ChatListRoute(),
        ChatRoute(
          chatRoom: chatRoom,
        ),
      ]);
    }
  }

  static Future<String> getToken() async {
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(AppConstants.serviceAccount),
      AppConstants.scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(AppConstants.serviceAccount),
      AppConstants.scopes,
      client,
    );
    client.close();
    return credentials.accessToken.data;
  }

  // Future<void> sendNotification() async {
  //   Future<void> sendNotification(Map<String, dynamic> data) async {
  //     final
  //     try {
  //       final response = await dio.post(
  //         AppConstant.FIREBASE_MESSAGING_NOTIFICATION_URL,
  //         data: data,
  //         options: option,
  //       );
  //       print(response.data);
  //     } catch (e) {
  //       if (e is DioException) {
  //         print(e.response);
  //         print(e.error);
  //         print(e.message);
  //       }
  //     }
  //   }
  // }
}
