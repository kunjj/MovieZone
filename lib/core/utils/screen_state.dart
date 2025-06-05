sealed class ScreenState {
  static final loading = _Loading._();
  static final content = _Content._();
  static final error = _Error._();
}

class _Loading extends ScreenState {
  _Loading._();
}

class _Content extends ScreenState {
  _Content._();
}

class _Error extends ScreenState {
  _Error._();
}
