// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChatListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatListPage(),
      );
    },
    ChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatPage(),
      );
    },
    CodeVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<CodeVerificationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CodeVerificationPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    FriendsListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FriendsListPage(),
      );
    },
    LoadingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoadingPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    WrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WrapperPage(),
      );
    },
  };
}

/// generated route for
/// [ChatListPage]
class ChatListRoute extends PageRouteInfo<void> {
  const ChatListRoute({List<PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CodeVerificationPage]
class CodeVerificationRoute extends PageRouteInfo<CodeVerificationRouteArgs> {
  CodeVerificationRoute({
    Key? key,
    required String phoneNumber,
    List<PageRouteInfo>? children,
  }) : super(
          CodeVerificationRoute.name,
          args: CodeVerificationRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'CodeVerificationRoute';

  static const PageInfo<CodeVerificationRouteArgs> page =
      PageInfo<CodeVerificationRouteArgs>(name);
}

class CodeVerificationRouteArgs {
  const CodeVerificationRouteArgs({
    this.key,
    required this.phoneNumber,
  });

  final Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'CodeVerificationRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [FriendsListPage]
class FriendsListRoute extends PageRouteInfo<void> {
  const FriendsListRoute({List<PageRouteInfo>? children})
      : super(
          FriendsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendsListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoadingPage]
class LoadingRoute extends PageRouteInfo<void> {
  const LoadingRoute({List<PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WrapperPage]
class WrapperRoute extends PageRouteInfo<void> {
  const WrapperRoute({List<PageRouteInfo>? children})
      : super(
          WrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'WrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
