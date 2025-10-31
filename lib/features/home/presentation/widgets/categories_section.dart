import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/features/home/presentation/cubits/categories_cubit.dart';
import 'package:grid_view/features/home/presentation/cubits/categories_states.dart';
import 'package:grid_view/features/home/presentation/widgets/category_item_widget.dart';
import 'package:grid_view/generated/l10n.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).categories,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesloadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CategoriesFailureState) {
              return Center(child: Text("Error: ${state.errorMessage}"));
            } else if (state is CategoriesSuccessState) {
              final List<dynamic> categories = state.categories;
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          log(
                            "Clicked Category : ${categories[index]['name']}",
                          );
                          Navigator.pushNamed(
                            context,
                            '/products-filter',
                            arguments: categories[index]['name'],
                          );
                        },
                        child: CategoryItemWidget(
                          categoryName: categories[index]['name'],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
