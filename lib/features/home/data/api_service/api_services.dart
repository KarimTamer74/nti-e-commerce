import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grid_view/features/home/data/models/product_model.dart';

class ApiServices {
  static const String baseUrl = 'https://dummyjson.com';
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
  Future getAllProducts() async {
    try {
      List<ProductModel> products = [];
      final Response response = await dio.get("/products");
      final Map<String, dynamic> data = response.data;
      data['products'].map((element) {
        final product = ProductModel.fromMap(element);
        products.add(product);
      }).toList();

      return products;
      // log("Data: $data");
    } on Exception catch (error) {
      log("Error :$error");
    }
  }

  Future getCategories() async {
    try {
      final Response response = await dio.get('/products/categories');
      return response.data;
    } on DioException catch (error) {
      final String errorMessage = error.response?.data ?? error.message;
      log("Dio Error: $errorMessage");
      throw Exception(errorMessage);
    } on Exception catch (error) {
      print("Error :$error");
      throw Exception(error);
    }
  }

  Future deleteProduct({required String productId}) async {
    try {
      final Response response = await dio.delete('/products/$productId');
      log("Data: ${response.data}");
      return response.data;
    } on DioException catch (error) {
      final String errorMessage = error.response?.data ?? error.message;
      log("Dio Error: $errorMessage");
      throw Exception(errorMessage);
    } on Exception catch (e) {
      log("Error: $e");
      throw Exception(e.toString());
    }
  }
}
