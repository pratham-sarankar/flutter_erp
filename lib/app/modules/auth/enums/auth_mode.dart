enum AuthMode {
  login,
  register,
}

extension AuthModeExtension on AuthMode {
  String get text {
    switch (this) {
      case AuthMode.login:
        return "Login";
      case AuthMode.register:
        return "Register";
    }
  }

  AuthMode get toggle {
    switch (this) {
      case AuthMode.login:
        return AuthMode.register;
      case AuthMode.register:
        return AuthMode.login;
    }
  }
}
