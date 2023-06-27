// class MyInherited extends InheritedWidget {
//   final int count;
//
//   const MyInherited({
//     super.key,
//     required super.child,
//     required this.count,
//   });
//
//   @override
//   bool updateShouldNotify(MyInherited oldWidget) => oldWidget.count != count;
// }

import 'package:flutter/material.dart';

/// Get inherit and Subscribe at the same time
/// context.dependOnInheritedWidgetOfExactType<>();

/// Iherited Widgets
///
/// Inherited Models

/// Inherited Model
class DataProviderInherited extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;

  const DataProviderInherited({
    super.key,
    required super.child,
    required this.valueOne,
    required this.valueTwo,
  });

  @override
  bool updateShouldNotify(covariant DataProviderInherited oldWidget) {
    return oldWidget.valueOne != valueOne || oldWidget.valueTwo != valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant DataProviderInherited oldWidget, Set<String> dependencies) {
    final isValueOneChanged =
        (oldWidget.valueOne != valueOne) && dependencies.contains('one');
    final isValueTwoChanged =
        (oldWidget.valueTwo != valueTwo) && dependencies.contains('two');

    return isValueOneChanged || isValueTwoChanged;
  }
}
