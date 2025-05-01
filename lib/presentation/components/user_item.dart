import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/models/models.dart';
import '../styles/style.dart';
import 'components.dart';

class UserItem extends StatelessWidget {
  final UserData? user;
  final bool isSelected;
  final Function() onTap;

  const UserItem({
    super.key,
    required this.user,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 74.r,
        margin: REdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? Style.primary.withOpacity(0.06) : Style.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              margin: REdgeInsets.symmetric(vertical: 12),
              width: 4,
              decoration: ShapeDecoration(
                color: isSelected ? Style.primary : Style.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
              ),
            ),
            12.horizontalSpace,
            Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Style.black.withOpacity(0.06),
              ),
              alignment: Alignment.center,
              child: CommonImage(
                url: user?.img,
                width: 40,
                height: 40,
                radius: 20,
                errorRadius: 20,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user?.firstname} ${user?.lastname ?? ''}',
                    style: Style.interSemi(size: 15),
                  ),
                  4.verticalSpace,
                  Text(
                    user?.email ?? '',
                    style: Style.interNormal(size: 12),
                  ),
                ],
              ),
            ),
            16.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
