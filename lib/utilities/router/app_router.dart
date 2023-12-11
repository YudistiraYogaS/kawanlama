import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/constant/app_pages.dart';
import 'package:kawanlama/presentation/ui/auth/login_page.dart';
import 'package:kawanlama/presentation/ui/home/home_page.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: AppPages.loginRoute, page: LoginRoute.page, initial: true),
        AutoRoute(path: AppPages.homeRoute, page: HomeRoute.page),
      ];
}
