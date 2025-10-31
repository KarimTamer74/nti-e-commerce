import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/core/helper/app_shared_preferences.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.system);
  final AppPreferences _appPreferences = AppPreferences();
  bool? isDark = false;
  void getTheme() {
    isDark = _appPreferences.getData('isDarkMode');
    if (isDark == true) {
      emit(ThemeMode.dark);
    } else if (isDark == false) {
      emit(ThemeMode.light);
    } else {
      isDark = ThemeMode.system == ThemeMode.dark;

      emit(ThemeMode.system);
    }
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    log("New Theme: $newTheme");
    isDark = newTheme == ThemeMode.dark;
    await _appPreferences.setData('isDarkMode', isDark);
    log("IS Dark Mode? $isDark");
    emit(newTheme);
  }
}
