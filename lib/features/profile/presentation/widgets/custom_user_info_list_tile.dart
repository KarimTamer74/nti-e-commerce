import 'package:flutter/material.dart';
import 'package:grid_view/features/profile/data/models/user_info_model.dart';

class CustomUserInfoListTile extends StatelessWidget {
  const CustomUserInfoListTile({super.key, required this.userInfo});
  final UserInfoModel userInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if (userInfo.title == 'Log Out') {
          Navigator.pushNamed(context, '/');
        }
      },
      leading: Icon(userInfo.icon, size: 28),
      title: Text(
        userInfo.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
