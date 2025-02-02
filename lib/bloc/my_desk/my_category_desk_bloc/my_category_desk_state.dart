import '../../../models/prayer_category.dart';

enum MyDeskStatus { initial, loading, success, error }

class MyDeskState {
  final MyDeskStatus status;
  final List<Category>? categories;
  final String? errorMessage;

  MyDeskState({
    required this.status,
    this.categories,
    this.errorMessage,
  });

  MyDeskState copyWith({
    MyDeskStatus? status,
    List<Category>? categories,
    String? errorMessage,
  }) {
    return MyDeskState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
