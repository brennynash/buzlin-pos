import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';

class HeaderItem extends StatelessWidget {
  final String title;

  const HeaderItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppHelpers.getTranslation(title),
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, fontSize: 22, color: Style.black),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
               context.maybePop();
            },
            icon: const Icon(Remix.close_fill))
      ],
    );
  }
}
