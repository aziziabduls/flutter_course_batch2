import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/models/category_model.dart';
import 'package:flutter_course_batch_2/service_provider/dio_client.dart';

class ServiceProvider with ChangeNotifier {
  final DioClient dioClient;
  ServiceProvider(this.dioClient);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch Categories
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await dioClient.fetchCategories();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCategory(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await dioClient.deleteCategory(id);
      _categories.removeWhere((category) => category.id == id);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCategory(String name, String imageUrl) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Make the API call and get the response as a Map
      Map<String, dynamic> newCategoryData = await dioClient.createCategory(name, imageUrl);
      // Convert the Map to a Category object
      Category newCategory = Category.fromJson(newCategoryData);
      // Add the new category to the list
      _categories.add(newCategory);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}