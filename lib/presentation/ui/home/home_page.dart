import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kawanlama/application/auth_controller.dart';
import 'package:kawanlama/domain/constant/app_colors.dart';
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
    return AutoTabsScaffold(
      appBarBuilder: (context, _) => AppBar(
        actions: [IconButton.outlined(onPressed: () async => _doLogout(), icon: const Icon(Icons.logout))],
      ),
      routes: const [
        ContactRoute(),
        LoginRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          selectedIconTheme: IconThemeData(color: AppColors.primary),
          items: [
            BottomNavigationBarItem(label: I10n.current.contact, icon: const Icon(Icons.list)),
            BottomNavigationBarItem(label: I10n.current.favorite, icon: const Icon(Icons.favorite)),
          ],
        );
      },
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
