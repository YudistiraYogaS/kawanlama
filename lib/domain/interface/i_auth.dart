abstract interface class IAuth {
  Future<bool> signInWithGoogle();

  Future<bool> signOut();

  bool isLoggedIn();

  String userLoggedIn();
}
