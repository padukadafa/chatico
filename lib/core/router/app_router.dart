import 'package:auto_route/auto_route.dart';
import 'package:chatico/presentation/pages/chat/chat_page.dart';
import 'package:chatico/presentation/pages/chat_list/chat_list_page.dart';
import 'package:chatico/presentation/pages/wrapper/wrapper_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: ChatListRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: WrapperRoute.page,
        ),
        AutoRoute(page: ChatRoute.page),
      ];
}
