import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../exceptions/unsplash_exception.dart';


class DioClient {
  DioClient(String clientId) {
    _dio = Dio(BaseOptions(
        baseUrl: "https://api.unsplash.com",
        headers: {"Authorization": 'Client-ID $clientId'}));
  }
  late Dio _dio;

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (200 <= statusCode! && statusCode < 300) {
          return response.data;
        }
        throw throw UnsplashException.fromCode(statusCode);
      }
      throw UnsplashException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const UnsplashException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw UnsplashException.fromCode(error.response!.statusCode!);
      }
      throw UnsplashException(message: error.message);
    } on SocketException {
      throw const UnsplashException(message: "No Internet Connection");
    } on TimeoutException {
      throw const UnsplashException(message: "Server Not Responding");
    } catch (error) {
      throw UnsplashException(message: error.toString());
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (200 <= statusCode! && statusCode < 300) {
          return response.data;
        }
        throw throw UnsplashException.fromCode(statusCode);
      }
      throw UnsplashException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const UnsplashException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw UnsplashException.fromCode(error.response!.statusCode!);
      }
      throw UnsplashException(message: error.message);
    } on SocketException {
      throw const UnsplashException(message: "No Internet Connection");
    } on TimeoutException {
      throw const UnsplashException(message: "Server Not Responding");
    } catch (error) {
      throw UnsplashException(message: error.toString());
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (200 <= statusCode! && statusCode < 300) {
          return response.data;
        }
        throw throw UnsplashException.fromCode(statusCode);
      }
      throw UnsplashException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const UnsplashException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw UnsplashException.fromCode(error.response!.statusCode!);
      }
      throw UnsplashException(message: error.message);
    } on SocketException {
      throw const UnsplashException(message: "No Internet Connection");
    } on TimeoutException {
      throw const UnsplashException(message: "Server Not Responding");
    } catch (error) {
      throw UnsplashException(message: error.toString());
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (200 <= statusCode! && statusCode < 300) {
          return response.data;
        }
        throw throw UnsplashException.fromCode(statusCode);
      }
      throw UnsplashException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const UnsplashException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw UnsplashException.fromCode(error.response!.statusCode!);
      }
      throw UnsplashException(message: error.message);
    } on SocketException {
      throw const UnsplashException(message: "No Internet Connection");
    } on TimeoutException {
      throw const UnsplashException(message: "Server Not Responding");
    } catch (error) {
      throw UnsplashException(message: error.toString());
    }
  }
}
