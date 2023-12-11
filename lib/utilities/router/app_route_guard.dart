import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/interface/i_auth.dart';
import 'package:kawanlama/utilities/router/app_router.dart';

@lazySingleton
class AppRouteGuard extends AutoRouteGuard {
  final IAuth _authRepository;

  AppRouteGuard(this._authRepository);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (_authRepository.isLoggedIn()) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}