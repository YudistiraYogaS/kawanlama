import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/interface/i_auth.dart';

@lazySingleton
class AuthController extends GetxController {
  final IAuth _authRepository;

  AuthController(this._authRepository);

  Future<bool> signInWithGoogle() async => await _authRepository.signInWithGoogle();

  Future<bool> signOut() async => await _authRepository.signOut();
}