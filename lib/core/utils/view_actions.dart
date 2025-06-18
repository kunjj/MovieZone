// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';

abstract class ViewAction {}

enum DisplayMessageType { toast, dialog }

enum OverlayScreenType { bottomSheet, dialog }

class DisplayMessage extends ViewAction {
  final String? message;
  final String? title;
  final DisplayMessageType type;
  final dynamic data;

  DisplayMessage({
    this.message,
    this.title,
    this.type = DisplayMessageType.dialog,
    this.data,
  });

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, hash_and_equals
  bool operator ==(Object other) {
    return other is DisplayMessage && other.message == message && other.type == type && other.data == data;
  }
}

class CloseScreen extends ViewAction {}

class ChangeTheme extends ViewAction {}

@immutable
class NavigateScreen extends ViewAction {
  final String target;
  final Object? data;

  NavigateScreen(this.target, {this.data});

  @override
  // ignore: hash_and_equals
  bool operator ==(other) {
    if (other is NavigateScreen) {
      return other.target == target && other.data == data;
    } else {
      return false;
    }
  }
}

class OverlayScreen extends ViewAction {
  final OverlayScreenType overlayScreenType;
  final String target;
  final Object? data;

  OverlayScreen(this.target,{this.data,this.overlayScreenType = OverlayScreenType.dialog});

  @override
  // ignore: hash_and_equals
  bool operator ==(other) {
    if (other is OverlayScreen) {
      return other.overlayScreenType == overlayScreenType && other.target == target && other.data == data;
    } else {
      return false;
    }
  }
}
