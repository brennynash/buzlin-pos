import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class NotificationCountsContainer extends StatelessWidget {
  final int? count;

  const NotificationCountsContainer({super.key, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Style.primary),
      child: Center(
        child: Text(
          "${count ?? 0}",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Style.white,
          ),
        ),
      ),
    );
  }
}
