import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/constant/app_strings.dart';
import 'package:kawanlama/domain/interface/i_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IAuth)
class AuthRepository implements IAuth {
  final GoogleSignIn _googleSignIn;
  final SharedPreferences _preferences;

  AuthRepository(this._googleSignIn, this._preferences);

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final signIn = await _googleSignIn.signIn();
      if (signIn != null) {
        await _preferences.setBool(AppStrings.loginKey, true);
        await _preferences.setString(AppStrings.accountKey, signIn.email);
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      await _preferences.remove(AppStrings.loginKey);
      await _preferences.remove(AppStrings.accountKey);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool isLoggedIn() => _preferences.getBool(AppStrings.loginKey) ?? false;

  @override
  String userLoggedIn() => _preferences.getString(AppStrings.accountKey) ?? '';
}
