import 'package:admin_desktop/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class ViewCustomer extends StatelessWidget {
  final UserData? user;
  final VoidCallback back;

  const ViewCustomer({super.key, required this.user, required this.back});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.r,
        bottom: 16.r,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              back.call();
            },
            child: const BackButton(),
          ),
          12.verticalSpace,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 30.r),
              decoration: BoxDecoration(
                  color: Style.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CommonImage(
                        width: 108.r,
                        height: 108.r,
                        url: user?.img ?? "",
                        radius: 54.r,
                      ),
                      28.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user?.firstname ?? ""} ${user?.lastname ?? ""}",
                            style: GoogleFonts.inter(
                                fontSize: 24.sp, fontWeight: FontWeight.w600),
                          ),
                          8.verticalSpace,
                          Text(
                            "#${AppHelpers.getTranslation(TrKeys.id)}${user?.id ?? ""}",
                            style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Style.iconColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  46.verticalSpace,
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Style.white,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Style.primary, width: 5.r)),
                        width: 18.r,
                        height: 18.r,
                      ),
                      10.horizontalSpace,
                      Text(AppHelpers.getTranslation(TrKeys.male)),
                      32.horizontalSpace,
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Style.iconColor)),
                        width: 18.r,
                        height: 18.r,
                      ),
                      10.horizontalSpace,
                      Text(AppHelpers.getTranslation(TrKeys.female)),
                    ],
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      SizedBox(
                        width: 382.w,
                        child: OutlinedBorderTextField(
                          readOnly: true,
                          label: AppHelpers.getTranslation(TrKeys.firstname),
                          initialText: user?.firstname ?? "",
                        ),
                      ),
                      80.horizontalSpace,
                      SizedBox(
                        width: 382.w,
                        child: OutlinedBorderTextField(
                          readOnly: true,
                          label: AppHelpers.getTranslation(TrKeys.lastname),
                          initialText: user?.lastname ?? "",
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      SizedBox(
                        width: 382.w,
                        child: OutlinedBorderTextField(
                          readOnly: true,
                          label: AppHelpers.getTranslation(TrKeys.email),
                          initialText: user?.email ?? "",
                        ),
                      ),
                      80.horizontalSpace,
                      SizedBox(
                        width: 382.w,
                        child: OutlinedBorderTextField(
                          readOnly: true,
                          label: AppHelpers.getTranslation(TrKeys.phoneNumber),
                          initialText: user?.phone ?? "",
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      SizedBox(
                        width: 382.w,
                        child: OutlinedBorderTextField(
                          readOnly: true,
                          label: AppHelpers.getTranslation(TrKeys.idCode),
                          initialText:
                              "#${AppHelpers.getTranslation(TrKeys.id)}${user?.id}",
                        ),
                      ),
                      80.horizontalSpace,
                      SizedBox(
                        width: 382.w,
                        child: OutlinedBorderTextField(
                          readOnly: true,
                          label: AppHelpers.getTranslation(TrKeys.birth),
                          initialText: user?.birthday.toString() ?? "",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
