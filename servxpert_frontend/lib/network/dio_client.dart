import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

late Dio dio;
late PersistCookieJar cookieJar;

Future<void> setupDioWithCookies() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final cookiePath = "${appDocDir.path}/.cookies/";

  cookieJar = PersistCookieJar(
    storage: FileStorage(cookiePath),
  );

  dio = Dio(BaseOptions(
    baseUrl: "https://a3402b6a4143.ngrok-free.app", // optional
    headers: {
      'Content-Type': 'application/json',
    },
    followRedirects: false,
    validateStatus: (status) => status! < 500,
  ));

  dio.interceptors.add(CookieManager(cookieJar));
}
