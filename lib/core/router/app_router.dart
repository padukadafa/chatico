import 'package:auto_route/auto_route.dart';
import 'package:chatico/presentation/pages/chat/chat_page.dart';
import 'package:chatico/presentation/pages/chat_list/chat_list_page.dart';
import 'package:chatico/presentation/pages/auth/code_verification/code_verification_page.dart';
import 'package:chatico/presentation/pages/friends_list/friends_list_page.dart';
import 'package:chatico/presentation/pages/auth/login/login_page.dart';
import 'package:chatico/presentation/pages/loading/loading_page.dart';
import 'package:chatico/presentation/pages/wrapper/wrapper_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ChatListRoute.page),
        AutoRoute(page: WrapperRoute.page),
        AutoRoute(page: ChatRoute.page),
        AutoRoute(page: FriendsListRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: CodeVerificationRoute.page),
        AutoRoute(page: LoadingRoute.page, initial: true),
      ];
}
