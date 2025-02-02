import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../models/prayer_category.dart';
import '../../../services/my_desk_category_api_service.dart';
import 'my_category_desk_event.dart';
import 'my_category_desk_state.dart';

class MyDeskBloc extends Bloc<MyDeskEvent, MyDeskState> {
  final ApiServiceMyDesk apiServiceDesk;

  MyDeskBloc(this.apiServiceDesk) : super(MyDeskState(status: MyDeskStatus.initial)) {
    on<MyDeskEvent>((event, emit) async {
      if (event is LoadMyCategories) {
        await _loadCategories(emit);
      } else if (event is DeleteCategory) {
        await _deleteCategory(emit, event.columnId);
      } else if (event is AddCategory) {
        await _addCategory(emit, event.category);
      } else if (event is UpdateCategory) {
        await _updateCategory(emit, event.columnId, event.newTitle);
      }
    });
  }

  Future<void> _loadCategories(Emitter<MyDeskState> emit) async {
    emit(state.copyWith(status: MyDeskStatus.loading));
    try {
      final categories = await apiServiceDesk.getMyCategories();
      emit(state.copyWith(status: MyDeskStatus.success, categories: categories));
    } catch (e) {
      emit(state.copyWith(status: MyDeskStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _deleteCategory(Emitter<MyDeskState> emit, int columnId) async {
    try {
      await apiServiceDesk.deleteCategory(columnId);
      emit(state.copyWith(categories: await apiServiceDesk.getMyCategories()));
    } catch (e) {
      emit(state.copyWith(status: MyDeskStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _addCategory(Emitter<MyDeskState> emit, Category category) async {
    try {
      await apiServiceDesk.addCategory(category);
      emit(state.copyWith(categories: await apiServiceDesk.getMyCategories()));
    } catch (e) {
      emit(state.copyWith(status: MyDeskStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _updateCategory(Emitter<MyDeskState> emit, int columnId, String newTitle) async {
    try {
      await apiServiceDesk.updateCategory(columnId, newTitle);
      emit(state.copyWith(categories: await apiServiceDesk.getMyCategories()));
      emit(state.copyWith(status: MyDeskStatus.error, errorMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: MyDeskStatus.error, errorMessage: e.toString()));
    }
  }
}

