import 'package:admin_desktop/domain/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class SendPriceScreen extends ConsumerStatefulWidget {
  const SendPriceScreen({super.key});

  @override
  ConsumerState<SendPriceScreen> createState() => _SenPriceScreenState();
}

class _SenPriceScreenState extends ConsumerState<SendPriceScreen> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final delayed = Delayed(milliseconds: 700);
  late TextEditingController priceController;
  late TextEditingController userController;
  UserData? user;

  @override
  void initState() {
    priceController = TextEditingController();
    userController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void deactivate() {
    priceController.dispose();
    userController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletProvider);
    final notifier = ref.read(walletProvider.notifier);
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.send),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedBorderTextField(
                    hintText: AppHelpers.getTranslation(TrKeys.searchUser),
                    validator: AppValidators.emptyCheck,
                    textController: userController,
                    onChanged: (text) {
                      delayed.run(() {
                        notifier.searchUser(
                            context: context, search: text, isRefresh: true);
                      });
                    },
                    label: null,
                  ),
                  state.isSearchingLoading
                      ? const Loading()
                      : Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 16.r),
                              itemCount: state.listOfUser?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return UserItem(
                                  user: state.listOfUser?[index],
                                  onTap: () {
                                    userController.text =
                                        "${state.listOfUser?[index].firstname ?? ""} ${state.listOfUser?[index].lastname ?? ""}";
                                    user = state.listOfUser?[index];
                                  },
                                  isSelected: false,
                                );
                              }),
                        )
                ],
              ),
            ),
            CustomButton(
                bgColor: Style.primary,
                textColor: Style.white,
                isLoading: state.isButtonLoading,
                title: AppHelpers.getTranslation(TrKeys.pay),
                onTap: () {
                  if (form.currentState?.validate() ?? false) {
                    notifier.sendWallet(
                        context: context,
                        price: priceController.text,
                        onSuccess: () {
                          notifier.fetchTransactions(
                              context: context, isRefresh: true);
                          ref
                              .read(editProfileProvider.notifier)
                              .fetchUser(context);
                           context.maybePop();
                        },
                        uuid: user?.uuid ?? '');
                  }
                }),
            28.verticalSpace,
          ],
        ),
      ),
    );
  }
}
