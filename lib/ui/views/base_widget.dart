/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// BaseWidget every Stateful widget extends from.
class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  BaseWidget({Key key, this.builder, this.model, this.child, this.onModelReady})
      : super(key: key);

  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  @override
  State<StatefulWidget> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T model;

  /// When model != null execute the function [widget.onModelReady].
  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  /// Return a widget with a [ChangeNotifierProvider] to rebuild after a model
  /// calls notifyListeners().
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
