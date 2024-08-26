import 'package:flutter/material.dart';

/// Draws an [OutlineInputBorder] with the label within bounds,
/// instead of being placed in the middle of the border.
class CustomOutlineInputBorder extends OutlineInputBorder {
  const CustomOutlineInputBorder({
    super.borderSide,
    super.borderRadius,
  });

  // This is the field that defines where to draw the label.
  // If false, it will be put within the text field's bounds.
  @override
  bool get isOutline => false;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    // Call paint, but do not draw the gap in the border where the label would normally go.
    return super.paint(
      canvas,
      rect,
      textDirection: textDirection,
    );
  }
}