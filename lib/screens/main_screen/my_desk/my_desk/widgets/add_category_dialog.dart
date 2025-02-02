import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_bloc/app_widgets/app_colors.dart';
import 'package:prayer_bloc/app_widgets/custom_button.dart';
import 'package:prayer_bloc/app_widgets/typography.dart';

import '../../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_bloc.dart';
import '../../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_event.dart';
import '../../../../../models/prayer_category.dart';
import '../../../../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    bool isButtonEnabled = false;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'New Column',
                  style: AppTypography.heading1
                ),
                const SizedBox(width: 77),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.grayScale200,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AppColors.grayScale700,
                      size: 15,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelText: 'Enter title of column',
                  labelStyle: TextStyle(color: AppColors.grayScale300)),
              onChanged: (value) {
                isButtonEnabled = value.isNotEmpty;
              },
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
                text: 'Add',
                onPressed: isButtonEnabled
                    ? () async {
                  final newCategory = Category(
                    id: -1,
                    title: controller.text,
                    description: '',
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    deletedAt: null,
                  );
                  context.read<MyDeskBloc>().add(AddCategory(newCategory));
                  Navigator.of(context).pop();
                }
                    : null,
              backgroundColor:
              AuthTextEditingControllers.isSignInFormFilled
                  ? AppColors.grayScale800
                  : AppColors.grayScale300,
              foregroundColor: AppColors.grayScale100,
            ),
          ],
        ),
      ),
    );
  }
}
