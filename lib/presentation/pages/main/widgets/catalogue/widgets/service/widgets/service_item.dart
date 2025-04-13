import 'package:admin_desktop/presentation/pages/main/widgets/catalogue/widgets/service/widgets/service_pop_up.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class ServiceItem extends StatelessWidget {
  final ServiceData service;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final int spacing;

  const ServiceItem({
    super.key,
    required this.service,
    required this.onTap,
    this.spacing = 1,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.r,
      width: 280.r,
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          12.horizontalSpace,
          CommonImage(
            width: 60.r,
            height: 60.r,
            url: (service.galleries?.isNotEmpty ?? false)
                ? service.galleries?.first.path
                : null,
            errorRadius: 0,
            fit: BoxFit.cover,
          ),
          8.horizontalSpace,
          Expanded(
            child: AutoSizeText(
              AppHelpers.getTranslation(service.translation?.title ?? ''),
              style: Style.interNormal(
                size: 14,
                letterSpacing: -0.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Column(
            children: [
              ServicePopUp(onEdit: () => onTap(), onDelete: onDelete),
            ],
          )
        ],
      ),
    );
  }
}
