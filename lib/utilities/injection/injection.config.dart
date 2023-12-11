// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../../application/auth_controller.dart' as _i9;
import '../../domain/interface/i_auth.dart' as _i5;
import '../../infrastructure/core/register_module.dart' as _i10;
import '../../infrastructure/repository/auth_repository.dart' as _i6;
import '../router/app_route_guard.dart' as _i7;
import '../router/app_router.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.GoogleSignIn>(() => registerModule.googleSignIn);
    await gh.lazySingletonAsync<_i4.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i5.IAuth>(() => _i6.AuthRepository(
          gh<_i3.GoogleSignIn>(),
          gh<_i4.SharedPreferences>(),
        ));
    gh.lazySingleton<_i7.AppRouteGuard>(
        () => _i7.AppRouteGuard(gh<_i5.IAuth>()));
    gh.lazySingleton<_i8.AppRouter>(
        () => _i8.AppRouter(gh<_i7.AppRouteGuard>()));
    gh.lazySingleton<_i9.AuthController>(
        () => _i9.AuthController(gh<_i5.IAuth>()));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
