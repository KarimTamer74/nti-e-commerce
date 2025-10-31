import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductsFilterScreen extends StatefulWidget {
  const ProductsFilterScreen({super.key});

  @override
  State<ProductsFilterScreen> createState() => _ProductsFilterScreenState();
}

class _ProductsFilterScreenState extends State<ProductsFilterScreen> {
  final Dio dio = Dio();
  String myCategory = '';
  Future<List<dynamic>?> getProductsByCategory() async {
    try {
      final Response response = await dio.get(
        "https://dummyjson.com/products/category/$myCategory",
      );
      final Map<String, dynamic> data = response.data;
      final List<dynamic> products = data['products'];
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
            final List<dynamic> products = snapshot.data!;
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
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    products![index]['thumbnail'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                          child: const Icon(Icons.error),
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index]['title'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      products[index]['price'].toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Stock: ${products[index]['stock']}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
