import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kawanlama/application/auth_controller.dart';
import 'package:kawanlama/presentation/components/app_button.dart';
import 'package:kawanlama/utilities/i10n/l10n.dart';
import 'package:kawanlama/utilities/injection/injection.dart';
import 'package:kawanlama/utilities/router/app_router.dart';
import 'package:kawanlama/utilities/utilities.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController _authController = getIt<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton.defaults(
          title: I10n.current.logout,
          onPressed: () async => await _doLogout(),
        ),
      ),
    );
  }

  Future<void> _doLogout() async {
    try {
      final result = await _authController.signOut();
      if (result && context.mounted) {
        context.router.replaceAll([const LoginRoute()]);
      }
    } catch (e) {
      showError(e);
    }
  }
}
