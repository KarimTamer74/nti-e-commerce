import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/features/auth/data/api_services/auth_api_services.dart';
import 'package:grid_view/features/auth/data/models/register_request_model.dart';
import 'package:grid_view/features/auth/presentation/cubit/register_cubit/register_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthApiServices authApiServices = AuthApiServices();
  Future<void> signUp({required RegisterRequestModel requestModel}) async {
    emit(RegisterLoadingState());
    await authApiServices
        .signUp(request: requestModel)
        .then(
          (value) {
            log("Sign up successfuly");
            emit(RegisterSuccssState());
          },
          onError: (error) {
            log("Sign up failed with error $error");
            emit(RegisterFailureState());
          },
        );
  }
}
