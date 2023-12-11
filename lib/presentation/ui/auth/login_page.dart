import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kawanlama/application/auth_controller.dart';
import 'package:kawanlama/domain/constant/app_assets.dart';
import 'package:kawanlama/domain/constant/app_strings.dart';
import 'package:kawanlama/presentation/components/app_button.dart';
import 'package:kawanlama/presentation/ui/auth/components/greeting_widgets.dart';
import 'package:kawanlama/utilities/i10n/l10n.dart';
import 'package:kawanlama/utilities/injection/injection.dart';
import 'package:kawanlama/utilities/router/app_router.dart';
import 'package:kawanlama/utilities/utilities.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = getIt<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const GreetingsWidget(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton.defaults(
              title: I10n.current.sign_in_with(AppStrings.google),
              onPressed: () async => await _doLogin(),
              assets: AppAssets.icGoogle,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _doLogin() async {
    try {
      final result = await _authController.signInWithGoogle();
      if (result && context.mounted) {
        context.router.replaceAll([const HomeRoute()]);
      }
    } catch (e) {
      showError(e);
    }
  }
}
