import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/features/home/data/models/product_model.dart';
import 'package:grid_view/features/home/presentation/cubits/products_cubit.dart';
import 'package:grid_view/features/home/presentation/cubits/products_states.dart';
import 'package:grid_view/features/home/presentation/widgets/product_card_widget.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is DeleteProductLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Loading..."),
              duration: Duration(seconds: 1),
            ),
          );
        } else if (state is DeleteProductFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failure"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
            ),
          );
        } else if (state is DeleteProductSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Success..."),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GetProductsLoadingState) {
          log("Loading...........");
          return Center(child: CircularProgressIndicator());
        }
        if (state is GetProductsFailureState) {
          log("Failure State");

          return Text("Error :${state.errorMessage}");
        }
        if (state is GetProductsSuccessState) {
          final List<ProductModel> products = state.products;

          if (products.isEmpty) {
            return Text('No Products');
          }
          return GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: .7,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.white,

                onTap: () {
                  log("Inkwell Pressed");
                  log("Clicked Item: ${products[index]}");
                  Navigator.pushNamed(
                    context,
                    '/product-details',
                    arguments: products[index],
                  );
                },
                child: ProductCardWidget(product: products[index]),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
