import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/constant/endpointes.dart';
import '../../features/auth/domain/auth_repository.dart';
import 'persist_data.dart';
export 'package:dio/dio.dart';

/// [DioHelper] is a class that contains all the methods that are used to
/// communicate with the API
///
/// [dio] is the instance of the Dio package
///
/// [init] is used to initialize the Dio package
///
/// [getData] is used to get data from the API
///
/// [postData] is used to post data to the API
///
/// [putData] is used to put data to the API
///
/// [deleteData] is used to delete data from the API
///
///
class DioHelper {
  static late Dio dio;

  /// This method is used to initialize the Dio package
  /// [init] is used to initialize the Dio package
  /// [dio] is the instance of the Dio package
  /// [baseUrl] is the base url of the API
  /// [connectTimeout] is the time to wait for the server to send data
  /// [receiveTimeout] is the time to wait for the server to send data
  /// [receiveDataWhenStatusError] is used to receive data when the status is an error
  /// [validateStatus] is used to validate the status
  /// [contentType] is the type of the content
  /// [responseType] is the type of the response
  ///

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15), // Quick fail if offline
        receiveTimeout: const Duration(minutes: 2), // Give slow APIs more time
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

bool _isRefreshing = false;
Completer<void>? _refreshCompleter;

dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) async {
      if (options.path.contains(Endpoints.login) ||
          options.path.contains(Endpoints.refresh)) {
        return handler.next(options);
      }

      final expiryDate = await PersistData.getTokenExpiry();
      final refreshToken = await PersistData.getRefreshToken();
      var accessToken = await PersistData.getAccessToken();

      final isTokenExpired = expiryDate != null &&
          DateTime.now().add(const Duration(seconds: 5)).isAfter(expiryDate);

      if (isTokenExpired && refreshToken != null) {
        if (_isRefreshing) {
          print("⏳ Waiting for ongoing refresh to complete...");
          await _refreshCompleter?.future;
        } else {
          _isRefreshing = true;
          _refreshCompleter = Completer();

          try {
            accessToken = await AuthRepository.refreshToken(refreshToken);
          } catch (err) {
            print("❌ Refresh token error (onRequest): $err");
            await PersistData.clearAuthData();
            return handler.reject(DioException(
              requestOptions: options,
              error: "Session expired - please login again",
            ));
          } finally {
            _isRefreshing = false;
            _refreshCompleter?.complete();
            _refreshCompleter = null;
          }
        }
      }

      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      } else {
        print("⚠️ No access token available to attach to request");
      }

      return handler.next(options);
    },

    onError: (DioException error, handler) async {
      if (error.response?.statusCode == 401 &&
          !(error.requestOptions.extra['retried'] == true)) {
        final refreshToken = await PersistData.getRefreshToken();

        if (refreshToken != null) {
          try {
            final newAccess =
                await AuthRepository.refreshToken(refreshToken);

            final retryOptions = error.requestOptions
              ..extra['retried'] = true;
            retryOptions.headers['Authorization'] = 'Bearer $newAccess';

            print("🔁 Retrying original request...");
            final cloneReq = await dio.fetch(retryOptions);
            return handler.resolve(cloneReq);
          } catch (err) {
            print("❌ Refresh after 401 failed: $err");
            await PersistData.clearAuthData();
          }
        }
      }
      return handler.next(error);
    },
  ),
);




  }

  /// [getData] is used to get data from the API
  /// [url] is the endpoint of the API
  /// [query] is the query of the API
  /// [token] is the token of the API
  ///
  /// example:
  /// ```dart
  /// return await DioHelper.getData(
  ///    url: "${Endpoints.member}/$id",
  ///    token: token,
  /// );
  ///
  /// ```
  ///

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.get(url,
        queryParameters: query,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
          },
        ));
  }

  /// [postData] is used to post data to the API
  /// [url] is the endpoint of the API
  /// [query] is the query of the API
  /// [data] is the data of the API
  /// [token] is the token of the API
  ///
  /// example:
  /// ```dart
  /// return await DioHelper.postData(
  ///  url: Endpoints.login,
  ///  data: {
  ///  'email': email,
  ///  'password': password,
  ///  },
  /// );
  ///
  /// ```

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.post(url,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
          },
        ));
  }

  /// [putData] is used to put data to the API
  /// [url] is the endpoint of the API
  /// [query] is the query of the API
  /// [data] is the data of the API
  /// [token] is the token of the API
  ///
  /// example:
  /// ```dart
  /// return await DioHelper.putData(
  /// url: "${Endpoints.member}/$id",
  /// token: token,
  /// data: {
  /// 'memberName': memberName,
  /// },
  /// );
  /// ```
  ///
  ///

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.put(url,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
          },
        ));
  }

  /// [deleteData] is used to delete data from the API
  /// [url] is the endpoint of the API
  /// [query] is the query of the API
  /// [data] is the data of the API
  /// [token] is the token of the API
  ///
  /// example:
  /// ```dart
  /// return await DioHelper.deleteData(
  /// url: "${Endpoints.member}/$id",
  /// token: token,
  /// );
  /// ```
  ///

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept-Language": "EN",
        },
      ),
    );
  }

  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.patch(url,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
          },
        ));
  }
}