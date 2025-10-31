import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/core/locale/locale_cubit.dart';

class LocalizationListTile extends StatefulWidget {
  const LocalizationListTile({super.key});

  @override
  State<LocalizationListTile> createState() => _LocalizationListTileState();
}

class _LocalizationListTileState extends State<LocalizationListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.language, size: 28),
        SizedBox(width: 10),
        Text(
          "Language",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Spacer(),
        DropdownMenu(
          label: Text("Select"),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          onSelected: (value) {
            log("Selected lang: $value");
            BlocProvider.of<LocaleCubit>(context).chnageLanguage(value ?? 'en');
          },
          dropdownMenuEntries: [
            DropdownMenuEntry(value: 'en', label: "English"),
            DropdownMenuEntry(value: 'ar', label: "العربية"),
          ],
        ),
      ],
    );
  }
}
