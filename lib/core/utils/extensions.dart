import 'dart:convert';

import 'enum.dart';
import 'images.dart';
import 'regexp.dart';

extension StringUtil on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isBlank => this == null || this!.trim().isEmpty;

  bool get isNotBlank => !isBlank;

  bool get isNullOrBlank => this == null || isBlank;

  bool get isNotNullOrBlank => !isNullOrBlank;

  bool get isValidEmail => BaseRegExps.email.hasMatch(this ?? '');

  bool get isValidPhoneNumber => BaseRegExps.phoneNumber.hasMatch(this ?? '');

  bool get isValidPassword => BaseRegExps.password.hasMatch(this ?? '');

  String get toTitleCase =>
      this == null ? '' : '${this![0].toUpperCase()}${this!.substring(1)}';

  String get toBase64 => base64.encode(utf8.encode(this ?? ''));

  String get capitalize => this == null
      ? ''
      : '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
}

extension ListUtil on List<String> {
  String get joinToString => reduce((curr, next) => '$curr,$next');
}

extension ImageIcon on TextFieldSuffixIconType {
  static String _imageIcon(TextFieldSuffixIconType val) {
    switch (val) {
      case TextFieldSuffixIconType.cancel:
        return Images.cancel;
      case TextFieldSuffixIconType.showObscureText:
        return Images.showObscureText;
      case TextFieldSuffixIconType.hideObscureText:
        return Images.hideObscureText;
    }
  }

  String get imageIcon => _imageIcon(this);
}
