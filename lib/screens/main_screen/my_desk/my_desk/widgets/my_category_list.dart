import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/app_widgets/app_colors.dart';

import '../../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_bloc.dart';
import '../../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_event.dart';
import '../../../../../models/prayer_category.dart';


class CategoryListView extends StatelessWidget {
  final List<Category> categories;

  const CategoryListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Dismissible(
          key: Key(category.id.toString()),
          background: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            context.read<MyDeskBloc>().add(DeleteCategory(category.id));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: TextField(
                  controller: TextEditingController(text: category.title),
                  onSubmitted: (value) {
                    category.title = value;
                    final columnId = category.id;
                    context.read<MyDeskBloc>().add(UpdateCategory(columnId, value));
                  },
                  onTap: () {
                    GoRouter.of(context).go(
                        '/prayers/${category.id}/${Uri.encodeComponent(category.title)}');
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
