import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/features/home/data/api_service/api_services.dart';
import 'package:grid_view/features/home/presentation/cubits/categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitialState());
  final ApiServices apiServices = ApiServices();
  Future getCategories() async {
    emit(CategoriesloadingState());
    await apiServices.getCategories().then(
      (value) {
        log("Value in Categories cubit: $value");
        emit(CategoriesSuccessState(categories: value));
      },
      onError: (error) {
        log("Eroor: $error");
        emit(CategoriesFailureState(errorMessage: error.toString()));
      },
    );
  }
}
