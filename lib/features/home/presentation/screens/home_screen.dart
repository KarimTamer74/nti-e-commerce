import 'package:flutter/material.dart';
import 'package:grid_view/features/home/presentation/widgets/categories_section.dart';
import 'package:grid_view/features/home/presentation/widgets/products_section.dart';
import 'package:grid_view/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).eCommerce)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Expanded(child: CategoriesSection()),
            Expanded(flex: 6, child: ProductsSection()),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
