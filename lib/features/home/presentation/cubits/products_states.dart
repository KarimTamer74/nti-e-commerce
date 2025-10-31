import 'package:grid_view/features/home/data/models/product_model.dart';

abstract class HomeStates {}

// Initial
class HomeInitialState extends HomeStates {}

// Products
class GetProductsLoadingState extends HomeStates {}

class GetProductsSuccessState extends HomeStates {
  final List<ProductModel> products;
  GetProductsSuccessState({required this.products});
}

class GetProductsFailureState extends HomeStates {
  final String errorMessage;
  GetProductsFailureState({required this.errorMessage});
}

class DeleteProductLoading extends HomeStates {}

class DeleteProductSuccess extends HomeStates {}

class DeleteProductFailure extends HomeStates {}
