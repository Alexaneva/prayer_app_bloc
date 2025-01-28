import '../../../models/prayer_category.dart';

enum UserDeskStatus { idle, loading, success, error }

abstract class UserDeskState {
  final UserDeskStatus status;

  UserDeskState(this.status);
}

class InitialCategoryDesk extends UserDeskState {
  InitialCategoryDesk() : super(UserDeskStatus.idle);
}

class LoadingCategoryDesk extends UserDeskState {
  LoadingCategoryDesk() : super(UserDeskStatus.loading);
}

class LoadedCategoryDesk extends UserDeskState {
  final List<Category> categories;

  LoadedCategoryDesk(this.categories) : super(UserDeskStatus.success);
}

class FailedLoadedCategoryDesk extends UserDeskState {
  final String error;

  FailedLoadedCategoryDesk(this.error) : super(UserDeskStatus.error);
}

class CategoryAdded extends UserDeskState {
  CategoryAdded() : super(UserDeskStatus.success);
}

class CategoryDeleted extends UserDeskState {
  CategoryDeleted() : super(UserDeskStatus.success);
}

class CategoryUpdated extends UserDeskState {
  CategoryUpdated() : super(UserDeskStatus.success);
}
