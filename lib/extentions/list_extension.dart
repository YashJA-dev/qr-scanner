import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension ListExt<E> on List<Widget> {
  List<Widget> separator(dynamic value, [bool doExpand = false]) {
    return isEmpty
        ? this
        : (expand(
            (child) => [
              child,
              value is Widget ? value : Gap(double.parse(value.toString())),
            ],
          ).toList()
          ..removeLast());
  }
}
