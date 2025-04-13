import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import '../../../../income/widgets/custom_date_picker.dart';
import 'widgets/product_multiselection.dart';
import 'widgets/type_drop_down.dart';

class AddDiscountPage extends ConsumerStatefulWidget {
  const AddDiscountPage({super.key});

  @override
  ConsumerState<AddDiscountPage> createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends ConsumerState<AddDiscountPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(addDiscountProvider.notifier).clear());
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Scaffold(
        backgroundColor: Style.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderItem(title: TrKeys.addDiscount),
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(addDiscountProvider);
                    final notifier = ref.read(addDiscountProvider.notifier);
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: SingleImagePicker(
                                  height: MediaQuery.sizeOf(context).height / 6,
                                  width: MediaQuery.sizeOf(context).height / 6,
                                  imageFilePath: state.imageFile,
                                  onImageChange: notifier.setImageFile,
                                  onDelete: () => notifier.setImageFile(null),
                                ),
                              ),
                              30.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppHelpers.getTranslation(TrKeys.status),
                                      style: Style.interNormal(),
                                    ),
                                    6.verticalSpace,
                                    CustomToggle(
                                      controller: ValueNotifier(state.active),
                                      onChange: (c) =>
                                          notifier.setActive(!(state.active)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          24.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: DiscountTypeDropDown(
                                  onTap: (value) =>
                                      notifier.setActiveIndex(value!),
                                  label: AppHelpers.getTranslation(TrKeys.type),
                                ),
                              ),
                              16.horizontalSpace,
                              Expanded(
                                child: OutlinedBorderTextField(
                                  label:
                                      '${AppHelpers.getTranslation(TrKeys.price)}${state.type != "fixed" ? "%" : ""}*',
                                  inputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  onChanged: notifier.setPrice,
                                  validator: AppValidators.emptyCheck,
                                  inputFormatters: [InputFormatter.currency],
                                ),
                              ),
                            ],
                          ),
                          24.verticalSpace,
                          OutlinedBorderTextField(
                            readOnly: true,
                            textController: state.dateController,
                            label:
                                '${AppHelpers.getTranslation(TrKeys.startDate)} - ${AppHelpers.getTranslation(TrKeys.endDate)}',
                            inputType: TextInputType.number,
                            onTap: () {
                              AppHelpers.showAlertDialog(
                                context: context,
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomDatePicker(
                                        onValueChanged: notifier.setDate,
                                      ),
                                      CustomButton(
                                        title: TrKeys.close,
                                        onTap: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            validator: AppValidators.emptyCheck,
                          ),
                          24.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              AppHelpers.showAlertDialog(
                                  context: context,
                                  child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height / 2,
                                      width:
                                          MediaQuery.sizeOf(context).width / 3,
                                      child: const MultiSelectionWidget()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Style.colorGrey,
                                          width: 0.5.r))),
                              height: 40.r,
                              width: MediaQuery.sizeOf(context).width,
                              child: state.stocks.isEmpty
                                  ? Text(
                                      AppHelpers.getTranslation(TrKeys.select),
                                      style: Style.interNormal(
                                          size: 14, color: Style.colorGrey),
                                    )
                                  : ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.stocks.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Chip(
                                          backgroundColor: Style.primary,
                                          deleteIcon: Icon(
                                            Remix.close_circle_fill,
                                            size: 20.r,
                                            color: Style.white,
                                          ),
                                          onDeleted: () =>
                                              notifier.deleteFromAddedProducts(
                                                  state.stocks[index].id),
                                          label: Text(
                                            state.stocks[index].product
                                                    ?.translation?.title ??
                                                "",
                                            style: Style.interNormal(
                                                color: Style.white),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return 10.horizontalSpace;
                                      },
                                    ),
                            ),
                          ),
                          56.verticalSpace,
                          CustomButton(
                            bgColor: Style.primary,
                            textColor: Style.white,
                            title: AppHelpers.getTranslation(TrKeys.save),
                            isLoading: state.isLoading,
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                notifier.createDiscount(context, created: () {
                                  //widget.onSave();
                                  ref
                                      .read(discountProvider.notifier)
                                      .fetchDiscounts(
                                          context: context, isRefresh: true);
                                  context.maybePop();
                                }, onError: () {});
                              }
                            },
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
