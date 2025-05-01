import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'info_widget.dart';
import 'tracking_dialog.dart';

class TrackingInformation extends StatelessWidget {
  final OrderData? order;

  const TrackingInformation({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Style.borderColor),
      ),
      padding: REdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (order?.trackId != null)
            InfoWidget(
              title: TrKeys.trackId,
              info: order?.trackId ?? "",
            ),
          if (order?.trackUrl != null)
            InfoWidget(
              title: TrKeys.trackUrl,
              info: order?.trackUrl ?? "",
            ),
          if (order?.trackName != null)
            InfoWidget(
              title: TrKeys.trackName,
              info: order?.trackName ?? "",
            ),
          const Divider(),
          CustomButton(
            title: AppHelpers.getTranslation(TrKeys.editTrackingInformation),
            onTap: () {
              AppHelpers.showAlertDialog(
                  context: context,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: TrackingDialog(
                      onSuccess: () {},
                    ),
                  ),
                  backgroundColor: Style.bg);
            },
          ),
        ],
      ),
    );
  }
}
