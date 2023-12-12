import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kawanlama/domain/constant/app_colors.dart';
import 'package:uuid/uuid.dart';

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

String generateId() => const Uuid().v4();

String getInitial(String name) {
  String result = '';
  final split = name.replaceAll("'", "").split(' ').toList();
  for (var element in split) {
    result += element[0];
  }

  return result.length > 2 ? result.substring(0, 1) : result;
}
