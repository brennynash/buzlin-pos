import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class CircleChoosingButton extends StatelessWidget {
  final bool isActive;

  const CircleChoosingButton({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
          color: isActive ? Style.primary : Style.transparent,
          shape: BoxShape.circle,
          border: Border.all(
              color: !isActive ? Style.iconColor : Style.transparent,
              width: 2)),
      child: Center(
        child: Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: isActive ? Style.white : Style.transparent,
              shape: BoxShape.circle),
        ),
      ),
    );
  }
}
