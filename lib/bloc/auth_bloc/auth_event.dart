class AuthEvent {
  final String email;
  final String password;
  final String? name;

  AuthEvent({required this.email, required this.password, this.name});
}