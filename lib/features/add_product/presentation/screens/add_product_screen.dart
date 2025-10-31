import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grid_view/core/shared_widgets/custom_text_form_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  bool isLoading = false;
  final Dio dio = Dio();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future addProduct() async {
    setState(() {
      isLoading = true;
    });
    try {
      final Response response = await dio.post(
        'https://dummyjson.com/products/add',
        data: {},
      );
      setState(() {
        isLoading = false;
      });
      log("Data: ${response.data}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Product added successfuly",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    } on DioException catch (error) {
      log("Dio Error: ${error.response?.data ?? error.message}");
      setState(() {
        isLoading = false;
      });
    } on Exception catch (e) {
      log("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      log(
        "Title: ${_titleController.text},Price: ${_priceController.text}, Category:${_categoryController.text}",
      );
      await addProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product'), elevation: 0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                        controller: _titleController,
                        label: 'Title',
                        prefixIcon: const Icon(Icons.title_rounded),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _descController,
                        label: 'Description',
                        prefixIcon: const Icon(Icons.description_outlined),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _stockController,
                              label: 'Stock',
                              keyboardType: TextInputType.number,

                              prefixIcon: const Icon(
                                Icons.inventory_2_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextFormField(
                              controller: _priceController,
                              label: 'Price',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),

                              prefixIcon: const Icon(
                                Icons.attach_money_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _categoryController,
                        label: 'Category',
                        hint: 'e.g. shoes, bags',
                        prefixIcon: const Icon(Icons.category_outlined),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: _submit,
                          child: isLoading
                              ? Center(child: CircularProgressIndicator())
                              : const Text(
                                  'Submit Product',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
