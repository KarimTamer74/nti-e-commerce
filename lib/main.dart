import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grid_view/core/helper/app_bloc_observer.dart';
import 'package:grid_view/core/helper/app_shared_preferences.dart';
import 'package:grid_view/core/locale/locale_cubit.dart';
import 'package:grid_view/core/theme/app_theme_cubit.dart';
import 'package:grid_view/core/theme/app_theme_data.dart';
import 'package:grid_view/features/add_product/presentation/screens/add_product_screen.dart';
import 'package:grid_view/features/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:grid_view/features/auth/presentation/screens/login_screen.dart';
import 'package:grid_view/features/auth/presentation/screens/register_screen.dart';
import 'package:grid_view/features/home/presentation/screens/home_screen.dart';
import 'package:grid_view/features/home/presentation/screens/product_details_screen.dart';
import 'package:grid_view/features/home/presentation/screens/products_filter_screen.dart';
import 'package:grid_view/features/profile/presentation/screens/profile_screen.dart';
import 'package:grid_view/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().init();
  Bloc.observer = AppBlocObserver();
  AppThemeCubit appThemeCubit = AppThemeCubit();
  appThemeCubit.getTheme();
  runApp(MyApp(appThemeCubit: appThemeCubit));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appThemeCubit});
  final AppThemeCubit appThemeCubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: appThemeCubit),
        BlocProvider(create: (context) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<AppThemeCubit, ThemeMode>(
            builder: (context, theme) {
              return MaterialApp(
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: locale,
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.dark,
                darkTheme: AppTheme.darkTheme,
                theme: AppTheme.lightTheme,
                title: 'Grid Shop',
                initialRoute: '/',
                routes: {
                  '/': (_) => const LoginScreen(),
                  '/sign-up': (_) => BlocProvider(
                    create: (context) => AuthCubit(),
                    child: const SignUpScreen(),
                  ),
                  '/home': (_) => const HomeScreen(),
                  '/add-product': (_) => const AddProductScreen(),
                  '/profile': (_) => const ProfileScreen(),
                  '/product-details': (_) => ProductDetails(),
                  '/products-filter': (_) => ProductsFilterScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
//* The problem: Appbar & buttons example
//* Solving: theme in material app
//* How make app operate on dark theme
//* Light theme and dark theme in matrial and seperate files
//* Custom Switch
//* Cubit with variable
//* Extension 
//* hydrated & shared pref