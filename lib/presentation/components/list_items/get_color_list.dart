import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class ColorListWidget extends StatelessWidget {
  final List<Extras> listExtra;

  const ColorListWidget(this.listExtra, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Wrap(
        direction: Axis.vertical,
        spacing: 6.0,
        runSpacing: 6.0,
        children: listExtra.map((extra) => getColorContainer(extra)).toList(),
      ),
    );
  }

  Widget getColorContainer(Extras extra) {
    return AppHelpers.checkIfHex(extra.value)
        ? Container(
            // margin: EdgeInsets.only(right: 6),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Color(
                int.parse('0xFF${extra.value?.substring(1, 7)}'),
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          )
        : const SizedBox.shrink();
  }
}
