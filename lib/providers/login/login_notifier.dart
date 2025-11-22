import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_demo/providers/login/login_state.dart';
import 'package:podcast_demo/services/api_service.dart';

import '../../data/api_client.dart';

class LoginNotifier extends Notifier<LoginState> {
  Future<void> login(String phone, String password) async {
    state = state.copyWith(loading: true, error: null);

    try {
      final response = await ref
          .read(apiServiceProvider)
          .login(phoneNumber: phone, password: password);

      state = state.copyWith(loading: false, response: response, error: null);

    } catch (e) {
      final message = getErrorMessage(e);

      state = state.copyWith(
        loading: false,
        error: message,
      );

    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  LoginState build() {
    return LoginState().copyWith(loading: false, response: null, error: null);
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
