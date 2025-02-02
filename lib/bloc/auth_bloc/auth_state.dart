
enum AuthStatus { loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? message;

  AuthState({this.status = AuthStatus.loading, this.message});
}
