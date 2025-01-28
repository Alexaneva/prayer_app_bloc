
enum AuthStatus { idle, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? message;

  AuthState({this.status = AuthStatus.idle, this.message});
}
