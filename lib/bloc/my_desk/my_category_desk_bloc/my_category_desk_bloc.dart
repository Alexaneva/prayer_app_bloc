import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../models/prayer_category.dart';
import '../../../services/my_desk_category_api_service.dart';
import 'my_category_desk_event.dart';
import 'my_category_desk_state.dart';

class MyDeskBloc extends Bloc<MyDeskEvent, MyDeskState> {
  final ApiServiceMyDesk apiServiceDesk;

  MyDeskBloc(this.apiServiceDesk) : super(InitialCategoryDesk()) {
    on<MyDeskEvent>((event, emit) async {
      switch (event.type) {
        case MyDeskEventType.loadMyCategories:
          await _loadCategories(emit);
          break;
        case MyDeskEventType.deleteCategory:
          await _deleteCategory(emit, event.columnId!);
          break;
        case MyDeskEventType.addCategory:
          await _addCategory(emit, event.category!);
          break;
        case MyDeskEventType.updateCategory:
          await _updateCategory(emit, event.columnId!, event.newTitle!);
          break;
      }
    });
  }

  Future<void> _loadCategories(Emitter<MyDeskState> emit) async {
    emit(LoadingCategoryDesk());
    try {
      final categories = await apiServiceDesk.getMyCategories();
      emit(LoadedCategoryDesk(categories));
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }

  Future<void> _deleteCategory(Emitter<MyDeskState> emit, int columnId) async {
    try {
      await apiServiceDesk.deleteCategory(columnId);
      emit(CategoryDeleted());
      add(MyDeskEvent.loadMyCategories());
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }

  Future<void> _addCategory(Emitter<MyDeskState> emit, Category category) async {
    try {
      await apiServiceDesk.addCategory(category);
      emit(CategoryAdded());
      add(MyDeskEvent.loadMyCategories());
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }

  Future<void> _updateCategory(Emitter<MyDeskState> emit, int columnId, String newTitle) async {
    try {
      await apiServiceDesk.updateCategory(columnId, newTitle);
      emit(CategoryUpdated());
      add(MyDeskEvent.loadMyCategories());
    } catch (e) {
      emit(FailedLoadedCategoryDesk(e.toString()));
    }
  }
}

