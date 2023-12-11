import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kawanlama/domain/constant/app_colors.dart';

Future<void> setStatusBarAndOrientation() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.primary.withOpacity(0.5),
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

void showUnInterruptLoading() => EasyLoading.show(maskType: EasyLoadingMaskType.black);

void showLoading() => EasyLoading.show(maskType: EasyLoadingMaskType.none);

void dismissLoading() => EasyLoading.isShow ? EasyLoading.dismiss() : null;

void showError(dynamic e) {
  if (EasyLoading.isShow) dismissLoading();
  EasyLoading.showError(e.toString());
}