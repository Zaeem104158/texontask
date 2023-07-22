import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/common_responses/error/error_response.dart';
import '../utils/constants.dart';
import '../utils/environment.dart';

class ApiClient {
  // ignore: unused_element
  ApiClient._();

  static final ApiClient apiClient = ApiClient._internal();
  late Dio _dio;

  ApiClient._internal() {
    var options = BaseOptions(
      baseUrl: getBaseUrl(),
    );
    _dio = Dio(options);
  }

  void getRequest(
    String url,
    ResponseCallback<dynamic, String?> callback, {
    bool checkStatusCodeOnly = false,
  }) async {
    final apiResponse = await client.get(
      url,
    );

    var responseData = apiResponse.data;
    if (apiResponse.statusCode == 200) {
      callback(responseData, null);
    } else if (apiResponse.statusCode == 201) {
      callback(responseData, null);
    } else if (apiResponse.statusCode == 204) {
      callback(null, "$responseData");
    } else {
      callback(null, "$responseData");
    }

    try {} on DioError catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, "$e");
    }
  }

  String? _getDioErrorResponse(DioError e) {
    var response = e.response;
    var statusCode = response?.statusCode;

    if (response?.data != null) {
      try {
        if (statusCode != null && statusCode == 401 ||
            statusCode == 403 ||
            statusCode! >= 500) {
          if (statusCode! >= 500) {
            return "Internal Server Error: $statusCode";
          } else {
            ErrorResponse errorResponse =
                ErrorResponse.fromJson(response?.data);
            var message = errorResponse.error?.message;
            return message != null && message.isNotEmpty
                ? message
                : errorResponse.error?.message;
          }
        } else {}
      } catch (e) {
        return e.toString();
      }
    } else {
      return e.message;
    }
    return "";
  }

  Dio get client {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.none) {
            return handler.reject(
                DioError(
                    requestOptions: options,
                    error: "internet_connectivity_problem"),
                true);
          }
        } catch (e) {
          return handler.reject(
              DioError(
                  requestOptions: options, error: "Error: ${e.toString()}"),
              true);
        }

        return handler.next(options);
      },
      onError: (error, handler) async {
        var errorResponse = error.response;
        // ignore: unused_local_variable
        RequestOptions? requestOptions = errorResponse?.requestOptions;

        if (errorResponse?.statusCode == 403) {
          // ignore: deprecated_member_use
          _dio.interceptors.requestLock.lock();
          // ignore: deprecated_member_use
          _dio.interceptors.responseLock.lock();

          try {
            var newDio = Dio();

            if (kDebugMode) {
              newDio.interceptors.clear();
              newDio.interceptors.add(LogInterceptor(
                error: true,
                request: true,
                requestBody: true,
                responseBody: true,
                requestHeader: true,
                logPrint: (object) {
                  log(object.toString());
                },
              ));
            }
          } catch (e) {
            return handler.next(error);
          }
        }

        return handler.next(error);
      },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        logPrint: (object) {
          log(object.toString());
        },
      ));
    }

    return _dio;
  }
}

extension _AsOptions on RequestOptions {
  Options asOptions() {
    return Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }
}
