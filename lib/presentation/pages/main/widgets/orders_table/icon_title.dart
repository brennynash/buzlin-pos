import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class IconTitle extends StatelessWidget {
  final String? title;
  final IconData icon;
  final String value;

  const IconTitle(
      {super.key, this.title, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 21),
          4.horizontalSpace,
          Expanded(
            child: Text(
              "${title == null ? '' : '$title:'} $value",
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Style.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
