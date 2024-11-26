import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/models/product_model.dart';
import 'package:flutter_course_batch_2/service_provider/modul_service/product_service.dart';

class ServiceProvider extends ChangeNotifier {
  ServiceProvider();

  ProductService productService = ProductService();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // get product provider
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProductsProvider() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await productService.getProducts();
    } on TimeoutException {
      _errorMessage = 'Error: Request Timeout';
    } on Exception catch (e) {
      _errorMessage = e.toString();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // delete product provider
  // function

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }
}
