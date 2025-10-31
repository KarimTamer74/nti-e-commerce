import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/core/theme/app_theme_cubit.dart';

class ThemeSwitchWidget extends StatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDarkActive = BlocProvider.of<AppThemeCubit>(context).isDark ?? false;

    return SwitchListTile(
      contentPadding: EdgeInsets.all(10),
      secondary: Icon(isDarkActive ? Icons.dark_mode : Icons.sunny, size: 28),
      title: Text(
        "Dark Theme",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      value: isDarkActive,
      onChanged: (bool value) {
        log("Value: $value");
        setState(() {
          isDarkActive = value;
        });
        BlocProvider.of<AppThemeCubit>(
          context,
        ).changeTheme(isDarkActive ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
