import 'package:flutter/material.dart';
import 'package:grid_view/features/profile/data/models/user_info_model.dart';
import 'package:grid_view/core/utils/string_manager.dart';

class AppStaticLists {
  static List<UserInfoModel> userInfoItems = [
    UserInfoModel(title: AppStrings.favorite, icon: Icons.favorite),

    UserInfoModel(title: "Downloads", icon: Icons.download),
    UserInfoModel(title: "Languages", icon: Icons.language),
    UserInfoModel(title: "Location", icon: Icons.map),
    UserInfoModel(title: "Subscribtion", icon: Icons.subscript),
    UserInfoModel(title: "Display", icon: Icons.display_settings),
    UserInfoModel(title: "Clear Cache", icon: Icons.delete),
    UserInfoModel(title: "Clear History", icon: Icons.lock_clock),

    UserInfoModel(title: "Log Out", icon: Icons.logout),
  ];
}
