import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_bloc.dart';
import '../../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_event.dart';
import '../../../../../models/prayer_category.dart';

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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 23),
                ),
                const SizedBox(width: 77),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey[200],
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[700],
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
                  labelStyle: TextStyle(color: Colors.grey[300])),
              onChanged: (value) {
                isButtonEnabled = value.isNotEmpty;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
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
                context.read<MyDeskBloc>().add(MyDeskEvent.addCategory(newCategory));
                Navigator.of(context).pop();
              }
                  : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                isButtonEnabled ? Colors.black : Colors.grey.shade300,
                minimumSize: const Size(400, 60),
              ),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
