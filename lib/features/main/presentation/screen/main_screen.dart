import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/core/theme/app_theme_cubit.dart';
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
    bool isDark = BlocProvider.of<AppThemeCubit>(context).isDark!;
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        color: isDark ? Colors.white : Colors.black,
        activeColor: Colors.orange,
        backgroundColor: isDark ? Colors.black : Colors.white,
        style: TabStyle.custom,
        items: [
          TabItem(
            icon: Icon(
              Icons.home,
              size: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: 'Home',
          ),
          TabItem(
            icon: Icon(
              Icons.add,
              size: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: 'Add',
          ),
          TabItem(
            icon: Icon(
              Icons.people,
              size: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
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
