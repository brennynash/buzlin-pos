import 'package:admin_desktop/application/catalogue/catalogue_notifier.dart';
import 'package:admin_desktop/application/masters/edit/edit_masters_notifier.dart';
import 'package:admin_desktop/application/masters/edit/edit_masters_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../product/widgets/view_mode.dart';
import 'widgets/edit_master_info.dart';
import 'widgets/working_time.dart';

class EditMasterPage extends StatelessWidget {
  final EditMastersState state;
  final EditMastersNotifier editMasterNotifier;
  final CatalogueNotifier notifier;

  const EditMasterPage(
      {super.key,
      required this.state,
      required this.notifier,
      required this.editMasterNotifier});

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: CustomScaffold(
        body: (c) => Column(
          children: [
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  onPressed: () => notifier.changeState(1),
                ),
                Text(
                  AppHelpers.getTranslation(TrKeys.editMaster),
                  style: Style.interNormal(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ViewMode(
                      title: AppHelpers.getTranslation(TrKeys.info),
                      isActive: state.index == 0,
                      isLeft: true,
                      onTap: () => editMasterNotifier.changeIndex(0),
                    ),
                    ViewMode(
                      title: AppHelpers.getTranslation(TrKeys.hour),
                      isActive: state.index == 1,
                      isRight: true,
                      onTap: () {
                        editMasterNotifier.changeIndex(1);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: state.index == 0
                  ? EditMasterInfo(master: state.masterData)
                  : const MastersWorkingTime(),
            ),
          ],
        ),
      ),
    );
  }
}
