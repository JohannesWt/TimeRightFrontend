/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';

/// BaseModel from which every further models extends.
/// BaseModel extends Change Notifier to implement notifyListeners() method
/// to notify ui listeners when a state in a model changed.
class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  /// Set busy to a boolean to show that a model is busy (loading data etc.)
  /// in the ui. (e.g. with a circular loading indicator)
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}