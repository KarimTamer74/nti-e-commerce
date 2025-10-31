import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/core/helper/app_static_lists.dart';
import 'package:grid_view/core/locale/locale_cubit.dart';
import 'package:grid_view/features/profile/data/models/user_info_model.dart';
import 'package:grid_view/features/profile/presentation/widgets/custom_user_info_list_tile.dart';

class ProfileListView extends StatelessWidget {
  const ProfileListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserInfoModel> userInfoItems = AppStaticLists.userInfoItems;
    return ListView.builder(
      itemCount: userInfoItems.length,
      itemBuilder: (context, index) {
        return (index == 1 || index == 5 || index == 8)
            ? Column(
                children: [
                  CustomUserInfoListTile(userInfo: userInfoItems[index]),

                  Divider(thickness: 2),
                ],
              )
            : CustomUserInfoListTile(userInfo: userInfoItems[index]);
      },
    );
  }
}

// class ThemeListTile extends StatefulWidget {
//   const ThemeListTile({super.key});

//   @override
//   State<ThemeListTile> createState() => _ThemeListTileState();
// }

// class _ThemeListTileState extends State<ThemeListTile> {
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkActive = false;
//     print("isDarkActive: $isDarkActive");
//     return SwitchListTile(
//       contentPadding: EdgeInsets.all(0),
//       secondary: Icon(Icons.dark_mode, size: 28),
//       title: Text(
//         "Dark Mode",
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//       ),
//       value: isDarkActive,
//       onChanged: (newValue) {
//         setState(() {
//           isDarkActive = newValue;
//           // context.read<AppThemeCubit>().changeTheme(
//           // isDarkActive ? ThemeMode.dark : ThemeMode.light,
//           // );
//         });
//       },
//     );
//   }
// }

