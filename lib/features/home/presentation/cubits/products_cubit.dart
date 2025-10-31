import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/features/home/data/api_service/api_services.dart';
import 'package:grid_view/features/home/data/models/product_model.dart';
import 'package:grid_view/features/home/presentation/cubits/products_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  final ApiServices apiServices = ApiServices();
  List<ProductModel> products = [];
  Future getAllProducts() async {
    emit(GetProductsLoadingState());
    await apiServices.getAllProducts().then(
      (value) {
        log("Value in Cubit: $value");
        products = value;
        emit(GetProductsSuccessState(products: value));
      },
      onError: (error) {
        log("Error in Cubit: $error");

        emit(GetProductsFailureState(errorMessage: error));
      },
    );
  }

  Future deleteProduct({required String productId}) async {
    emit(DeleteProductLoading());
    await apiServices
        .deleteProduct(productId: productId)
        .then(
          (value) async {
            products.removeWhere((element) {
              bool isEqual = element.id.toString() == productId;
              return isEqual;
            });
            emit(DeleteProductSuccess());

            // emit(GetProductsSuccessState(products: products));
          },
          onError: (error) {
            log("Error in Delete cubit $error");
            emit(DeleteProductFailure());
          },
        );
  }
}
