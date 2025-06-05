import 'package:built_value/built_value.dart';

import '../../../core/utils/screen_state.dart';

part 'splash_state.g.dart';

abstract class SplashData implements Built<SplashData, SplashDataBuilder> {
  factory SplashData([void Function(SplashDataBuilder) updates]) = _$SplashData;

  SplashData._();

  ScreenState get state;

  bool get isUserLoggedIn;
}

abstract class SplashState {}

class DisplaySplash extends SplashState {}

class Authenticated extends SplashState {}

class UnAuthenticated extends SplashState {}
