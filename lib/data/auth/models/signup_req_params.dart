class SignUpReqParams {
  SignUpReqParams(String email, String password) {
    _email = email;
    _password = password;
  }

  String? _email;
  String? _password;

  Map<String, String?> toJson() => {'email': _email, 'password': _password};
}
