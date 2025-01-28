import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_bloc/bloc/user_desk/user_category_desk_bloc/user_category_desk_event.dart';
import 'package:prayer_bloc/bloc/user_desk/user_category_desk_bloc/user_category_desk_state.dart';


import '../../../models/prayer_category.dart';
import '../../../services/user_desk_category_api_service.dart';


class UserDeskBloc extends Bloc<UserDeskEvent, UserDeskState> {
  final ApiServiceUserDesk apiServiceDesk;

  UserDeskBloc(this.apiServiceDesk) : super(InitialCategoryDesk()) {
    on<UserDeskEvent>((event, emit) async {
      switch (event.type) {
        case UserDeskEventType.loadMyCategories:
          await _loadCategories(emit);
          break;
        case UserDeskEventType.deleteCategory:
          await _deleteCategory(emit, event.columnId!);
          break;
        case UserDeskEventType.addCategory:
          await _addCategory(emit, event.category!);
          break;
        case UserDeskEventType.updateCategory:
          await _updateCategory(emit, event.columnId!, event.newTitle!);
          break;
      }
    });
  }

  Future<void> _loadCategories(Emitter<UserDeskState> emit) async {
    emit(LoadingCategoryDesk());
    try {
      final categories = await apiServiceDesk.getUserCategories();
      emit(LoadedCategoryDesk(categories));
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }

  Future<void> _deleteCategory(Emitter<UserDeskState> emit, int columnId) async {
    try {
      await apiServiceDesk.deleteUserCategory(columnId);
      emit(CategoryDeleted());
      add(UserDeskEvent.loadMyCategories());
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }

  Future<void> _addCategory(Emitter<UserDeskState> emit, Category category) async {
    try {
      await apiServiceDesk.addUserCategory(category);
      emit(CategoryAdded());
      add(UserDeskEvent.loadMyCategories());
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }

  Future<void> _updateCategory(Emitter<UserDeskState> emit, int columnId, String newTitle) async {
    try {
      await apiServiceDesk.updateUserCategory(columnId, newTitle);
      emit(CategoryUpdated());
      add(UserDeskEvent.loadMyCategories());
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }
}