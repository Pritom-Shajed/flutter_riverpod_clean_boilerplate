import 'dart:convert';
import 'dart:io';

import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_template/src/core/base/endpoints/api_endpoints.dart';
import 'package:flutter_clean_architecture_template/src/core/base/enum/method.dart';
import 'package:flutter_clean_architecture_template/src/core/base/failure/failure.dart';
import 'package:flutter_clean_architecture_template/src/core/base/interceptors/refresh_token_interceptor.dart';
import 'package:flutter_clean_architecture_template/src/core/base/model/api_response.dart';
import 'package:flutter_clean_architecture_template/src/core/base/model/auth_store.dart';
import 'package:flutter_clean_architecture_template/src/core/config/constants.dart';
import 'package:flutter_clean_architecture_template/src/core/config/environment.dart';
import 'package:flutter_clean_architecture_template/src/core/config/type_defs.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/extensions/extensions.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/logger/logger_helper.dart';
import 'package:flutter_clean_architecture_template/src/features/settings/data/models/settings_model.dart';
import 'package:flutter_clean_architecture_template/src/features/settings/data/repositories/hive_box.dart';
import 'package:flutter_clean_architecture_template/src/injector.dart';

class ApiClient {
  AuthStore? authStore;
  final Dio dio = Dio();

  Future<void> init() async {
    _configureDio();

    authStore = Boxes.authStores.get(appName.toCamelWord);
    log.f('AuthStore: $authStore');
    log.f('AuthStore: ${authStore?.isAccessTokenValid}');

    if (authStore != null && !authStore!.isRefreshTokenValid) {
      await signout();
      log.e('Automatically signed out due to invalid refresh token.');
    } else if (authStore != null && !authStore!.isAccessTokenValid) {
      log.i('Automatically refreshing access token.');
      await _refreshToken();
    }

    _listenForAuthStore();
  }

  void _listenForAuthStore() {
    Boxes.authStores
        .watch(key: appName.toCamelWord)
        .listen((_) => authStore = Boxes.authStores.get(appName.toCamelWord));
  }

  void _configureDio() {
    final baseUrl = sl<AppSettings>().isProduction ? Environment.prodBaseUrl : Environment.devBaseUrl;

    dio.options.baseUrl = baseUrl;
    dio.options.headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          log.e('Dio Error: ${e.message}');
          return handler.next(e);
        },
      ),
      // RefreshTokenInterceptor(dio: dio, apiClient: this),
      AwesomeDioInterceptor(logResponseHeaders: false),
    ]);
  }

  bool get isLoggedIn => authStore != null && authStore!.accessToken.isNotEmpty;

  Future<void> signout() async {
    try {
      await authStore?.deleteData();
      authStore = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> get _token async {
    if (authStore == null) return null;
    return await _refreshToken();
  }

  Future<String?> _refreshToken() async {
    if (authStore == null) return null;
    log.f('Refresh token: ${authStore!.refreshToken}');

    log.i('Token refreshing...');
    final response = await dio.post('/${ApiEndpoints.refreshToken}', data: {'refresh-token': authStore!.refreshToken});

    final apiResponse = ApiResponse.fromRawJson(jsonEncode(response.data));
    if (!apiResponse.success) throw apiResponse.message;

    authStore!.accessToken = apiResponse.data['access-token'];
    authStore!.refreshToken = apiResponse.data['refresh-token'];
    log.i('New tokens: ${apiResponse.data}');
    await authStore!.save();
    return authStore!.accessToken;
  }

  ResultFuture<String> request(
    ApiClientMethod method,
    String endPoint, {
    Map<String, dynamic>? data,
    bool isAuthRequired = true,
  }) async {
    String? token;
    if (isAuthRequired) {
      token = await _token;
      if (token == null) throw 'Session expired. Please sign in again.';
    }

    final headers = {'Content-Type': 'application/json', if (isAuthRequired) 'Authorization': 'Bearer $token'};

    Response response;

    try {
      switch (method) {
        case ApiClientMethod.get:
          response = await dio.get('/$endPoint', options: Options(headers: headers));
          break;
        case ApiClientMethod.post:
          response = await dio.post(
            '/$endPoint',
            data: data,
            options: Options(headers: headers),
          );
          break;
        case ApiClientMethod.put:
          response = await dio.put(
            '/$endPoint',
            data: data,
            options: Options(headers: headers),
          );
          break;
        case ApiClientMethod.delete:
          response = await dio.delete(
            '/$endPoint',
            data: data,
            options: Options(headers: headers),
          );
          break;
        case ApiClientMethod.patch:
          response = await dio.patch(
            '/$endPoint',
            data: data,
            options: Options(headers: headers),
          );
          break;
      }

      log.i('Response of $endPoint by $method: ${response.data}');
      return Right(jsonEncode(response.data));
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      log.e('Error From Dio Exception: $message');
      return Left(ServerFailure('Oops! Error Occured: $message'));
    } on SocketException catch (e) {
      log.e('Error From Socket Exception: $e');
      return Left(NetworkFailure('No internet connection. ${e.message}'));
    } catch (e) {
      log.e('Error From Catch Block: $e');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  ResultFuture<Response> storeFile(List<String> paths, {bool isAuthRequired = true}) async {
    String? token;
    if (isAuthRequired) {
      token = await _token;
      if (token == null) throw 'Session expired. Please sign in again.';
    }

    final formData = FormData();
    for (final path in paths) {
      formData.files.add(MapEntry('files', await MultipartFile.fromFile(path, filename: path.split('/').last)));
    }

    final headers = {if (isAuthRequired) 'Authorization': 'Bearer $token'};

    try {
      final response = await dio.post(
        '/file',
        data: formData,
        options: Options(headers: headers),
      );
      return Right(response);
    } on DioException catch (e) {
      log.e('Error From Dio Exception (File Upload): $e');
      final message = e.response?.data['message'] ?? e.message;
      return Left(ServerFailure('API error: $message'));
    } on SocketException catch (e) {
      log.e('Error From Socket Exception (File Upload): $e');
      return Left(NetworkFailure('No internet connection. ${e.message}'));
    } catch (e) {
      log.e('Error From Catch Block (File Upload): $e');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
