import 'dart:convert';
import 'dart:developer';

import 'package:flutter_course_batch_2/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  // get product
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        log("service_method::${response.request} -> params_response::${jsonData.toString()}");
        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw ('Failed to load products');
      }
    } catch (e) {
      throw ('No Connection');
    }
  }
}
