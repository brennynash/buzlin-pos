import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/gift_cards/edit/edit_gift_card_notifier.dart';
import 'package:admin_desktop/application/gift_cards/edit/edit_gift_card_provider.dart';
import 'package:admin_desktop/application/gift_cards/gift_card_provider.dart';
import 'package:admin_desktop/domain/models/data/gift_card_data.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class EditGiftCardPage extends ConsumerStatefulWidget {
  final GiftCardData? giftCardData;

  const EditGiftCardPage({super.key, required this.giftCardData});

  @override
  @override
  ConsumerState<EditGiftCardPage> createState() => _EditGiftCardPageState();
}

class _EditGiftCardPageState extends ConsumerState<EditGiftCardPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;
  late TextEditingController price;
  late EditGiftCardNotifier notifier;

  @override
  void initState() {
    title = TextEditingController(
      text: widget.giftCardData?.translation?.title ?? '',
    );
    desc = TextEditingController(
      text: widget.giftCardData?.translations?.first.description ?? '',
    );
    price = TextEditingController(text: "${widget.giftCardData?.price ?? ''}");

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(editGiftCardProvider.notifier).fetchGiftCardDetails(
              context: context,
              giftCard: widget.giftCardData,
              onSuccess: (description) {
                desc.text = description ?? '';
              },
            ));
  }

  @override
  void didChangeDependencies() {
    notifier = ref.read(editGiftCardProvider.notifier);
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
    final state = ref.watch(editGiftCardProvider);
    return KeyboardDisable(
      child: Scaffold(
        body: state.giftCardData == null || state.isLoading
            ? const Loading()
            : Column(
                children: [
                  const HeaderItem(title: TrKeys.editGiftCard),
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
                              label: AppHelpers.getPriceLabel,
                              textInputAction: TextInputAction.next,
                              textController: price,
                              inputFormatters: [InputFormatter.currency],
                              validator: AppValidators.emptyCheck,
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
                                    if (state.giftCardData?.time == null) {
                                      AppHelpers.errorSnackBar(
                                        context,
                                        text: AppHelpers.getTranslation(
                                          TrKeys.selectTime,
                                        ),
                                      );
                                    } else {
                                      notifier.updateGiftCard(
                                        context,
                                        updated: (value) {
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
                                  }
                                }),
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
