import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kawanlama/domain/constant/app_colors.dart';
import 'package:kawanlama/domain/constant/app_sizes.dart';
import 'package:kawanlama/firebase_options.dart';
import 'package:kawanlama/utilities/i10n/l10n.dart';
import 'package:kawanlama/utilities/injection/injection.dart';
import 'package:kawanlama/utilities/router/app_router.dart';
import 'package:kawanlama/utilities/utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setStatusBarAndOrientation();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(AppSizes.appScreenWidth, AppSizes.appScreenHeight),
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            I10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
          ],
          routerConfig: getIt<AppRouter>().config(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
