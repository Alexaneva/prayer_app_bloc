import '../../../models/prayer_category.dart';


enum MyDeskEventType {
  loadMyCategories,
  deleteCategory,
  addCategory,
  updateCategory,
}

class MyDeskEvent {
  final MyDeskEventType type;
  final int? columnId;
  final String? newTitle;
  final Category? category;

  MyDeskEvent.loadMyCategories()
      : type = MyDeskEventType.loadMyCategories,
        columnId = null,
        newTitle = null,
        category = null;

  MyDeskEvent.deleteCategory(this.columnId)
      : type = MyDeskEventType.deleteCategory,
        newTitle = null,
        category = null;

  MyDeskEvent.addCategory(this.category)
      : type = MyDeskEventType.addCategory,
        columnId = null,
        newTitle = null;

  MyDeskEvent.updateCategory(this.columnId, this.newTitle)
      : type = MyDeskEventType.updateCategory,
        category = null;
}
