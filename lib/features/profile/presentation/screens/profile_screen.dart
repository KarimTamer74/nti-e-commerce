import 'package:flutter/material.dart';
import 'package:grid_view/core/locale/change_locale_widget.dart';
import 'package:grid_view/core/theme/theme_switch_widget.dart';
import 'package:grid_view/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:grid_view/features/profile/presentation/widgets/user_info_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            UserInfoSection(),
            SizedBox(height: 20),
            ThemeSwitchWidget(),
            LocalizationListTile(),
            Expanded(child: ProfileListView()),
          ],
        ),
      ),
    );
  }
}

//* 1- Custom Widget that repeated
//* 2- model for data
//* 3- use model in custom widget
//* 4- ListView.builder and pass the data
