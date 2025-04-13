import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/gift_cards/add/add_gift_card_notifier.dart';
import 'package:admin_desktop/application/gift_cards/add/add_gift_card_provider.dart';
import 'package:admin_desktop/application/gift_cards/gift_card_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class AddGiftCardPage extends ConsumerStatefulWidget {
  const AddGiftCardPage({super.key});

  @override
  ConsumerState<AddGiftCardPage> createState() => _AddGiftCardPageState();
}

class _AddGiftCardPageState extends ConsumerState<AddGiftCardPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;
  late TextEditingController price;
  late AddGiftCardNotifier notifier;

  @override
  void initState() {
    title = TextEditingController();
    desc = TextEditingController();
    price = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(addGiftCardProvider.notifier).clear(),
    );
  }

  @override
  void didChangeDependencies() {
    notifier = ref.read(addGiftCardProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addGiftCardProvider);
    return KeyboardDisable(
      child: Scaffold(
        body: state.giftCardData == null || state.isLoading
            ? const Loading()
            : Column(
                children: [
                  const HeaderItem(title: TrKeys.addGiftCard),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            24.verticalSpace,
                            OutlinedBorderTextField(
                              hintText:
                                  '${AppHelpers.getTranslation(TrKeys.title)}*',
                              textInputAction: TextInputAction.next,
                              textController: title,
                              validator: AppValidators.emptyCheck,
                              label: null,
                            ),
                            12.verticalSpace,
                            OutlinedBorderTextField(
                              hintText:
                                  '${AppHelpers.getTranslation(TrKeys.description)}*',
                              textInputAction: TextInputAction.next,
                              textController: desc,
                              validator: AppValidators.emptyCheck,
                              label: null,
                            ),
                            12.verticalSpace,
                            OutlinedBorderTextField(
                              hintText: AppHelpers.getPriceLabel,
                              textInputAction: TextInputAction.next,
                              textController: price,
                              inputFormatters: [InputFormatter.currency],
                              validator: AppValidators.isNumberValidator,
                              label: null,
                            ),
                            12.verticalSpace,
                            OutlineDropDown(
                              value: state.giftCardData?.time,
                              list: DropDownValues.timeOptionsList,
                              onChanged: notifier.setTime,
                              hint: TrKeys.time,
                              label: null,
                            ),
                            12.verticalSpace,
                            Text(
                              AppHelpers.getTranslation(TrKeys.status),
                              style: Style.interNormal(),
                            ),
                            CustomToggle(
                              controller: ValueNotifier(state.active),
                              onChange: (c) =>
                                  notifier.setActive(!(state.active)),
                            ),
                            16.verticalSpace,
                            CustomButton(
                              title: AppHelpers.getTranslation(TrKeys.save),
                              isLoading: state.isLoading,
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  state.giftCardData?.time == null
                                      ? AppHelpers.errorSnackBar(
                                          context,
                                          text: AppHelpers.getTranslation(
                                              TrKeys.selectTime),
                                        )
                                      : notifier.createGiftCard(
                                          context,
                                          created: () {
                                            ref
                                                .read(giftCardProvider.notifier)
                                                .fetchGiftCards(
                                                  context: context,
                                                  isRefresh: true,
                                                );
                                             context.maybePop();
                                          },
                                          title: title.text,
                                          description: desc.text,
                                          price: price.text,
                                        );
                                }
                              },
                            ),
                            56.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
