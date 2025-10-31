abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesloadingState extends CategoriesState {}

class CategoriesFailureState extends CategoriesState {
  final String errorMessage;

  CategoriesFailureState({required this.errorMessage});
}

class CategoriesSuccessState extends CategoriesState {
  final List<dynamic> categories;

  CategoriesSuccessState({required this.categories});
}
