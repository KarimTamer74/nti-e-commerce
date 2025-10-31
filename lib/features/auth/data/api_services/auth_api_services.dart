import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grid_view/features/auth/data/models/register_request_model.dart';

class AuthApiServices {
  final Dio dio = Dio();
  Future<void> signUp({required RegisterRequestModel request}) async {
    log("Email: ${request.email}, pass: ${request.password}");

    try {
      final Response response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/register',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: request.toJson(),
      );
      log("In Sign Up Response data: ${response.data}");
    } on DioException catch (e) {
      String errorMessage = e.response?.data ?? e.message;
      log("Dio Error: $errorMessage");
      throw Exception(errorMessage);
    } catch (e) {
      log("Error: $e");
      throw Exception(e.toString());
    }
  }
}
