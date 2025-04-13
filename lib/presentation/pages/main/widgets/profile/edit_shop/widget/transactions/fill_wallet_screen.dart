import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class FillWalletScreen extends ConsumerStatefulWidget {
  const FillWalletScreen({super.key});

  @override
  ConsumerState<FillWalletScreen> createState() => _FillWalletScreenState();
}

class _FillWalletScreenState extends ConsumerState<FillWalletScreen> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  late TextEditingController priceController;

  @override
  void initState() {
    priceController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletProvider.notifier).fetchPayments(context: context);
    });
    super.initState();
  }

  @override
  void deactivate() {
    priceController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletProvider);
    final notifier = ref.read(walletProvider.notifier);
    return Form(
      key: form,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.fillWallet),
              style: Style.interNormal(),
            ),
            16.verticalSpace,
            OutlinedBorderTextField(
              hintText:
                  "${AppHelpers.getTranslation(TrKeys.price)} ${AppHelpers.getTranslation(LocalStorage.getSelectedCurrency()?.symbol ?? "")}",
              validator: AppValidators.emptyCheck,
              textController: priceController,
              inputType: TextInputType.number,
              label: null,
            ),
            16.verticalSpace,
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.list?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => notifier.selectPayment(index: index),
                      child: Column(
                        children: [
                          8.verticalSpace,
                          Row(
                            children: [
                              Icon(
                                state.selectPayment == index
                                    ? Remix.checkbox_circle_fill
                                    : Remix.checkbox_blank_circle_line,
                                color: state.selectPayment == index
                                    ? Style.primary
                                    : Style.black,
                              ),
                              10.horizontalSpace,
                              Text(
                                state.list?[index].tag ?? "",
                                style: Style.interNormal(
                                  size: 14,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          8.verticalSpace
                        ],
                      ),
                    );
                  }),
            ),
            16.verticalSpace,
            CustomButton(
                bgColor: Style.primary,
                textColor: Style.white,
                isLoading: state.isButtonLoading,
                title: AppHelpers.getTranslation(TrKeys.pay),
                onTap: () {
                  if (form.currentState?.validate() ?? false) {
                    notifier.fillWallet(
                        context: context,
                        walletId: LocalStorage.getUser()?.wallet?.id ?? 0,
                        price: priceController.text,
                        onSuccess: () {
                          notifier.fetchTransactions(
                              context: context, isRefresh: true);
                          ref
                              .read(editProfileProvider.notifier)
                              .fetchUser(context);
                           context.maybePop();
                        });
                  }
                }),
            28.verticalSpace,
          ],
        ),
      ),
    );
  }
}
