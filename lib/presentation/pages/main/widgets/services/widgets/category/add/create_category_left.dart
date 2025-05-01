import 'package:admin_desktop/presentation/pages/main/widgets/services/widgets/category/add/riverpod/create_service_category_notifier.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/services/widgets/category/add/riverpod/create_service_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class CreateCategoryLeft extends StatelessWidget {
  final CreateServiceCategoryNotifier notifier;
  final CreateServiceCategoryState state;

  const CreateCategoryLeft(
      {super.key, required this.notifier, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 140.w) / 3 * 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Style.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                6.verticalSpace,
                OutlinedBorderTextField(
                  label: "${AppHelpers.getTranslation(TrKeys.name)}*",
                  inputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onChanged: notifier.setTitle,
                  validator: AppValidators.emptyCheck,
                  textController: state.titleController,
                ),
                8.verticalSpace,
                OutlinedBorderTextField(
                  label: AppHelpers.getTranslation(TrKeys.description),
                  inputType: TextInputType.text,
                  textController: state.descriptionController,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onChanged: notifier.setDescription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
