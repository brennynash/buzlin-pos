import 'package:flutter/material.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../styles/style.dart';

class ProfileTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const ProfileTopBar({
    super.key,
    required this.title,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 64,
        decoration: BoxDecoration(
          color: isActive ? Style.white : Style.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppHelpers.getTranslation(title),
                style: Style.interMedium(size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
