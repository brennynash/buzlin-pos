import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../styles/style.dart';

class ColorItem extends StatelessWidget {
  final Extras extras;

  const ColorItem({super.key, required this.extras});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppHelpers.checkIfHex(extras.value)
            ? Container(
                width: 32,
                height: 32,
                margin: REdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                        int.parse('0xFF${extras.value?.substring(1, 7)}')),
                    border: Border.all(
                      color: extras.value?.substring(1, 7) == "ffffff"
                          ? Style.black
                          : Style.white,
                    )),
              )
            : Material(
                shape: const CircleBorder(),
                color: Style.white,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Style.black.withOpacity(0.1), width: 1.5),
                  ),
                  padding: REdgeInsets.all(8),
                  child: Text(
                    extras.value ?? '',
                    style: Style.interNormal(
                      size: 14,
                      color: Style.black,
                      letterSpacing: -14 * 0.01,
                    ),
                  ),
                ),
              ),
        if (LocalStorage.getLangLtr()) 5.horizontalSpace,
      ],
    );
  }
}
