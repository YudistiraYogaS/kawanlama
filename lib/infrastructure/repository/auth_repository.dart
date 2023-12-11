import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/interface/i_auth.dart';

@LazySingleton(as: IAuth)
class AuthRepository implements IAuth {
  final GoogleSignIn _googleSignIn;

  AuthRepository(this._googleSignIn);

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final signIn = await _googleSignIn.signIn();
      /// TODO: Save data to prefs
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
      /// TODO: Remove data from prefs
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
