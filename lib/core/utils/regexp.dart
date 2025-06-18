abstract class BaseRegExps {
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp phoneNumber = RegExp(r'(^[0-9]{6,14}$)');
  static final RegExp password =
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z].*[a-z].*[a-z])(?=.*[0-9].*[0-9].*[0-9])(?=.*[$&+,:;=?@#|_<>.\-^*()%!]).{8,}$');

  static final RegExp dob = RegExp(r'\s*\*.*');
  static final RegExp age = RegExp(r'^.*\* |Age : ');

  static final RegExp imageConvert = RegExp(r'\s+');
}
