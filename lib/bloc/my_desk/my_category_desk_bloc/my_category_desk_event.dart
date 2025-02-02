import '../../../models/prayer_category.dart';

abstract class MyDeskEvent {}

class LoadMyCategories extends MyDeskEvent {}

class DeleteCategory extends MyDeskEvent {
  final int columnId;

  DeleteCategory(this.columnId);
}

class AddCategory extends MyDeskEvent {
  final Category category;

  AddCategory(this.category);
}

class UpdateCategory extends MyDeskEvent {
  final int columnId;
  final String newTitle;

  UpdateCategory(this.columnId, this.newTitle);
}
