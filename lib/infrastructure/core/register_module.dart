import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn(scopes: ['email']);

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs  async => await SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio {
    Dio dio = Dio();
    BaseOptions baseOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: 120000),
      receiveTimeout: const Duration(milliseconds: 60000),
      sendTimeout: const Duration(milliseconds: 60000),
    );

    dio.options = baseOptions;
    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }
}