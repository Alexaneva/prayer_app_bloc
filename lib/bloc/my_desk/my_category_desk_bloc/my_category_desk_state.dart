

import '../../../models/prayer_category.dart';

enum MyDeskStatus { idle, loading, success, error }

abstract class MyDeskState {
  final MyDeskStatus status;

  MyDeskState(this.status);
}

class InitialCategoryDesk extends MyDeskState {
  InitialCategoryDesk() : super(MyDeskStatus.idle);
}

class LoadingCategoryDesk extends MyDeskState {
  LoadingCategoryDesk() : super(MyDeskStatus.loading);
}

class LoadedCategoryDesk extends MyDeskState {
  final List<Category> categories;

  LoadedCategoryDesk(this.categories) : super(MyDeskStatus.success);
}

class FailedLoadedCategoryDesk extends MyDeskState {
  final String error;

  FailedLoadedCategoryDesk(this.error) : super(MyDeskStatus.error);
}

class CategoryAdded extends MyDeskState {
  CategoryAdded() : super(MyDeskStatus.success);
}

class CategoryDeleted extends MyDeskState {
  CategoryDeleted() : super(MyDeskStatus.success);
}

class CategoryUpdated extends MyDeskState {
  CategoryUpdated() : super(MyDeskStatus.success);
}
