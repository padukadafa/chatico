import 'package:auto_route/auto_route.dart';
import 'package:chatico/presentation/pages/wrapper/wrapper_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WrapperRoute.page,
          initial: true,
        ),
      ];
}
