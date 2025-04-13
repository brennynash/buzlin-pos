import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/buttons/animation_button_effect.dart';
import '../../../../../styles/style.dart';

class MapButtons extends StatelessWidget {
  final VoidCallback zoomIn;
  final VoidCallback zoomOut;
  final VoidCallback navigate;

  const MapButtons(
      {super.key,
      required this.zoomIn,
      required this.zoomOut,
      required this.navigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 94.r,
          width: 50.r,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Style.shadow, offset: Offset(0, 2), blurRadius: 2)
            ],
            borderRadius: BorderRadius.circular(5.r),
            color: Style.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: ButtonEffectAnimation(
                  child: GestureDetector(
                    onTap: zoomIn,
                    child: Icon(
                      Icons.add,
                      size: 24.r,
                      color: Style.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.r),
                child: const Divider(
                  color: Style.unselectedBottomBarItem,
                ),
              ),
              Expanded(
                child: ButtonEffectAnimation(
                  child: GestureDetector(
                    onTap: zoomOut,
                    child: Icon(
                      Icons.remove,
                      size: 24.r,
                      color: Style.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        12.verticalSpace,
        ButtonEffectAnimation(
          child: InkWell(
            onTap: navigate,
            borderRadius: BorderRadius.circular(5.r),
            child: Container(
              height: 50.r,
              width: 50.r,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Style.shadow,
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.circular(5.r),
                color: Style.white,
              ),
              child: Icon(Remix.navigation_line, size: 20.r),
            ),
          ),
        )
      ],
    );
  }
}
