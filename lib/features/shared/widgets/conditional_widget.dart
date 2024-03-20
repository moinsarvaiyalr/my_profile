import 'package:flutter/widgets.dart';

/// A widget that conditionally renders one of two child widgets based on a provided boolean condition.
class ConditionalWidget extends StatelessWidget {
  /// Creates a [ConditionalWidget] widget.
  ///
  /// The [condition] determines whether to display [trueChild] or [falseChild].

  const ConditionalWidget({
    super.key,
    required this.condition,
    required this.trueChild,
    required this.falseChild,
  });

  /// The condition that determines which child widget to display.
  final bool condition;

  /// The child widget to display when [condition] is true.
  final Widget trueChild;

  /// The child widget to display when [condition] is false.
  final Widget falseChild;

  @override
  Widget build(BuildContext context) {
    return condition ? trueChild : falseChild;
  }
}
