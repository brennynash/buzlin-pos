import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter/material.dart';

class HourIndicatorSettings {
  final double height;
  final Color color;
  final double offset;
  final LineStyle lineStyle;
  final double dashWidth;
  final double dashSpaceWidth;

  const HourIndicatorSettings({
    this.height = 1.0,
    this.offset = 0.0,
    this.color = Style.greyColor,
    this.lineStyle = LineStyle.solid,
    this.dashWidth = 4,
    this.dashSpaceWidth = 4,
  });

  factory HourIndicatorSettings.none() => const HourIndicatorSettings(
        color: Style.transparent,
        height: 0.0,
      );
}
