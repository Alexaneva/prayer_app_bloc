import '../../../models/prayer_category.dart';

enum UserDeskEventType {
  loadMyCategories,
  deleteCategory,
  addCategory,
  updateCategory,
}

class UserDeskEvent {
  final UserDeskEventType type;
  final int? columnId;
  final String? newTitle;
  final Category? category;

  UserDeskEvent.loadMyCategories()
      : type = UserDeskEventType.loadMyCategories,
        columnId = null,
        newTitle = null,
        category = null;

  UserDeskEvent.deleteCategory(this.columnId)
      : type = UserDeskEventType.deleteCategory,
        newTitle = null,
        category = null;

  UserDeskEvent.addCategory(this.category)
      : type = UserDeskEventType.addCategory,
        columnId = null,
        newTitle = null;

  UserDeskEvent.updateCategory(this.columnId, this.newTitle)
      : type = UserDeskEventType.updateCategory,
        category = null;
}
