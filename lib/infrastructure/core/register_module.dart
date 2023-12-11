import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn(scopes: ['email']);

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs  async => await SharedPreferences.getInstance();
}