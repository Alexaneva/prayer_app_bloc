import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_api_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiService apiService;

  AuthBloc(this.apiService) : super(AuthState()) {
    on<AuthEvent>((event, emit) async {
      emit(AuthState(status: AuthStatus.loading));
      try {
        if (event.name != null) {
          await apiService.signUp(event.email, event.name!, event.password);
        } else {
          await apiService.signIn(event.email, event.password);
        }
        emit(AuthState(status: AuthStatus.success));
      } catch (e) {
        emit(AuthState(status: AuthStatus.error, message: e.toString()));
      }
    });
  }
}
