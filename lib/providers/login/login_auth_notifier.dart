import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginAuthNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }
  void checkCredentials(String phone, String password) {
    if (phone.isNotEmpty && password.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

final loginAuthProvider =
NotifierProvider<LoginAuthNotifier, bool>(LoginAuthNotifier.new);
