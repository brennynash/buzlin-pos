import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../application/order_detail/order_details_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class TrackingDialog extends StatefulWidget {
  final VoidCallback onSuccess;

  const TrackingDialog({super.key, required this.onSuccess});

  @override
  State<TrackingDialog> createState() => _TrackingDialogState();
}

class _TrackingDialogState extends State<TrackingDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController linkController;

  @override
  void initState() {
    nameController = TextEditingController();
    idController = TextEditingController();
    linkController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppHelpers.getTranslation(TrKeys.editTrackingInformation)),
          12.verticalSpace,
          OutlinedBorderTextField(
            label: TrKeys.name,
            textController: nameController,
            textCapitalization: TextCapitalization.sentences,
            validator: AppValidators.emptyCheck,
            textInputAction: TextInputAction.next,
          ),
          12.verticalSpace,
          OutlinedBorderTextField(
            label: TrKeys.id,
            textController: idController,
            validator: AppValidators.emptyCheck,
            textInputAction: TextInputAction.next,
          ),
          12.verticalSpace,
          OutlinedBorderTextField(
            textController: linkController,
            textCapitalization: TextCapitalization.sentences,
            validator: AppValidators.emptyCheck,
            label: TrKeys.link,
          ),
          12.verticalSpace,
          Consumer(builder: (context, ref, child) {
            return CustomButton(
                isLoading: ref.watch(orderDetailsProvider).isUpdating,
                title: TrKeys.save,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ref.read(orderDetailsProvider.notifier).updateOrderTracking(
                      context,
                      name: nameController.text,
                      id: idController.text,
                      url: linkController.text,
                      success: () {
                        widget.onSuccess.call();
                         context.maybePop();
                      },
                    );
                  }
                });
          })
        ],
      ),
    );
  }
}
