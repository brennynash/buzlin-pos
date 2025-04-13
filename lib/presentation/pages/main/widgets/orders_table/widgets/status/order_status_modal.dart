import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../language_switch.dart';
import 'riverpod/order_status_provider.dart';

class OrderStatusModal extends ConsumerStatefulWidget {
  final bool onlyShow;

  const OrderStatusModal({super.key, this.onlyShow = false});

  @override
  ConsumerState<OrderStatusModal> createState() => _OrderStatusModalState();
}

class _OrderStatusModalState extends ConsumerState<OrderStatusModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(orderStatusProvider.notifier)
          .setOrder(ref.read(orderDetailsProvider).order);
      ref.read(languagesProvider.notifier).getLanguages(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderStatusProvider);
    final languageState = ref.watch(languagesProvider);
    final notifier = ref.read(orderStatusProvider.notifier);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 2,
      width: MediaQuery.sizeOf(context).width / 2,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppHelpers.getTranslation(
                          state.order?.status ?? TrKeys.notes),
                      style: Style.interNormal(size: 16, color: Style.black),
                    ),
                  ),
                  LanguageSwitch(
                    languages: languageState.languages,
                    locale: state.locale,
                    onSelect: (index) {
                      notifier.setLanguage(
                        language: languageState.languages[index],
                        index: index,
                      );
                    },
                  ),
                ],
              ),
              16.verticalSpace,
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: REdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state.notes[index].title?[state.locale] ?? '',
                                  style: Style.interNormal(size: 14),
                                ),
                                4.verticalSpace,
                                Text(
                                  TimeService.dateFormatForOrder(
                                      state.notes[index].createdAt),
                                  style: Style.interNormal(
                                    color: Style.textColor,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                            if (!widget.onlyShow)
                              CircleButton(
                                  size: 32.r,
                                  icon: Remix.pencil_line,
                                  onTap: () {
                                    notifier.editNote(index);
                                  })
                          ],
                        ),
                      );
                    }),
              ),
              16.verticalSpace,
              if (!widget.onlyShow)
                OutlinedBorderTextField(
                  // hint: AppHelpers.getTranslation(TrKeys.title),
                  inputType: TextInputType.text,
                  textController: state.textEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  suffixIcon: state.editIndex != -1 && state.editIndex != null
                      ? CircleButton(
                          icon: Remix.close_line,
                          onTap: () => notifier.closeEdit())
                      : const SizedBox.shrink(),
                  label: TrKeys.title,
                ),
              36.verticalSpace,
              if (!widget.onlyShow)
                CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.save),
                  isLoading: state.isUpdating,
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      notifier.updateStatusNotes(
                        context,
                        success: () {
                          ref
                              .read(orderDetailsProvider.notifier)
                              .fetchOrderDetails(order: state.order);
                          context.maybePop();
                        },
                        status: AppHelpers.getOrderStatus(state.order?.status),
                      );
                    }
                  },
                ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
