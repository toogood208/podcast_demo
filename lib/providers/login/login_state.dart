import 'package:podcast_demo/models/login_response.dart';

class LoginState {
  final bool loading;
  final LoginResponse? response;
  final String? error;

  LoginState({
    this.loading = false,
    this.response,
    this.error,
  });


  LoginState copyWith({
    bool? loading,
    LoginResponse? response,
    String? error,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      response: response ?? this.response,
      error: error,
    );
  }
}