// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/main.dart';
import 'package:flutter_course_batch_2/models/category_model.dart';
import 'package:flutter_course_batch_2/service_provider/error_notifier.dart';
import 'package:provider/provider.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: 'https://api.escuelajs.co/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, handler) {
        String errorMessage;
        switch (e.type) {
          case DioErrorType.connectionTimeout:
            errorMessage = 'Connection timeout. Please try again.';
            break;
          case DioErrorType.receiveTimeout:
            errorMessage = 'Server took too long to respond.';
            break;
          case DioErrorType.badResponse:
            errorMessage = 'Error: ${e.response?.statusCode}, ${e.response?.data}';
            break;
          default:
            errorMessage = 'An unexpected error occurred.';
        }

        // Notify about the error
        final errorNotifier = Provider.of<ErrorNotifier>(navigatorKey.currentContext!, listen: false);
        errorNotifier.setErrorMessage(errorMessage);

        // Show the alert dialog
        _showErrorAlert(errorMessage);

        // Pass the error forward
        return handler.next(e);
      },
    ));
  }

  Future<void> _showErrorAlert(String message) async {
    if (navigatorKey.currentContext != null) {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await _dio.get('/categories');
      return (response.data as List).map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await _dio.delete('/categories/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createCategory(String name, String imageUrl) async {
    try {
      final response = await _dio.post('/categories', data: {
        "name": name,
        "image": imageUrl,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
