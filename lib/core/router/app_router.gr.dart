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
    WrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WrapperPage(),
      );
    }
  };
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
