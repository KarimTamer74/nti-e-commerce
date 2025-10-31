import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grid_view/features/home/data/models/product_model.dart';
import 'package:grid_view/features/home/presentation/widgets/product_card_widget.dart';

class ProductsFilterScreen extends StatefulWidget {
  const ProductsFilterScreen({super.key});

  @override
  State<ProductsFilterScreen> createState() => _ProductsFilterScreenState();
}

class _ProductsFilterScreenState extends State<ProductsFilterScreen> {
  final Dio dio = Dio();
  String myCategory = '';
  Future<List<ProductModel>?> getProductsByCategory() async {
    try {
      final Response response = await dio.get(
        "https://dummyjson.com/products/category/$myCategory",
      );
      final Map<String, dynamic> data = response.data;
      final List<ProductModel> products = [];
      data['products'].forEach((item) {
        ProductModel product = ProductModel.fromMap(item);
        products.add(product);
      });
      log("Products: $products");

      return products;
    } on DioException catch (error) {
      log("Dio Error: ${error.response?.data ?? error.message}");
      return null;
    } on Exception catch (error) {
      log("Error :$error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    myCategory = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text(myCategory), centerTitle: true),
      body: FutureBuilder(
        future: getProductsByCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final List<ProductModel> products = snapshot.data!;
            return products.isEmpty
                ? Center(
                    child: Text(
                      "No Products Found",
                      style: TextStyle(fontSize: 22),
                    ),
                  )
                : GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: .7,
                        ),
                    itemBuilder: (context, index) {
                      return InkWell(
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
          } else {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(fontSize: 22),
              ),
            );
          }
        },
      ),
    );
  }
}
