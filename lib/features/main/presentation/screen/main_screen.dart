import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/features/add_product/presentation/screens/add_product_screen.dart';
import 'package:grid_view/features/home/presentation/cubits/categories_cubit.dart';
import 'package:grid_view/features/home/presentation/cubits/products_cubit.dart';
import 'package:grid_view/features/home/presentation/screens/home_screen.dart';
import 'package:grid_view/features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => CategoriesCubit()..getCategories()),
      ],
      child: HomeScreen(),
    ),
    AddProductScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        color: Colors.white,
        activeColor: Colors.black,
        backgroundColor: Colors.orange,
        style: TabStyle.custom,
        items: const [
          TabItem(
            icon: Icon(Icons.home, size: 24, color: Colors.white),
            title: 'Home',
          ),
          TabItem(
            icon: Icon(Icons.add, size: 24, color: Colors.white),
            title: 'Add',
          ),
          TabItem(
            icon: Icon(Icons.people, size: 24, color: Colors.white),
            title: 'Profile',
          ),
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
