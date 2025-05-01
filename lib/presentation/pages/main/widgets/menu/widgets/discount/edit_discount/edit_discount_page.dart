import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import '../../../../income/widgets/custom_date_picker.dart';
import '../add_discount/widgets/product_multiselection.dart';
import '../add_discount/widgets/type_drop_down.dart';

class EditDiscountPage extends ConsumerStatefulWidget {
  final int id;

  const EditDiscountPage(this.id, {super.key});

  @override
  ConsumerState<EditDiscountPage> createState() => _EditDiscountPageState();
}

class _EditDiscountPageState extends ConsumerState<EditDiscountPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(editDiscountProvider.notifier)
          .fetchDiscountDetails(context: context, id: widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Scaffold(
        backgroundColor: Style.white,
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(editDiscountProvider);
            final notifier = ref.read(editDiscountProvider.notifier);
            return state.discount == null || state.isLoading
                ? const Loading()
                : SafeArea(
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeaderItem(title: TrKeys.editDiscount),
                              24.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: SingleImagePicker(
                                      //isEdit: true,
                                      height:
                                          MediaQuery.sizeOf(context).height / 6,
                                      width:
                                          MediaQuery.sizeOf(context).height / 6,
                                      isAdding: state.discount?.img == null,
                                      imageFilePath: state.imageFile,
                                      imageUrl: state.discount?.img,
                                      onImageChange: notifier.setImageFile,
                                      onDelete: () => notifier.setImageFile(null),
                                    ),
                                  ),
                                  24.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.status),
                                          style: Style.interNormal(),
                                        ),
                                        CustomToggle(
                                          controller:
                                              ValueNotifier(state.active),
                                          onChange: (c) => notifier
                                              .changeActive(!(state.active)),
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
                                      typeValue: state.discount?.type,
                                      label: AppHelpers.getTranslation(
                                          TrKeys.type),
                                    ),
                                  ),
                                  16.horizontalSpace,
                                  Expanded(
                                    child: OutlinedBorderTextField(
                                      label:
                                          '${AppHelpers.getTranslation(TrKeys.price)}${state.type != "fixed" ? "%" : ""}*',
                                      initialText:
                                          "${state.discount?.price ?? 0}",
                                      textInputAction: TextInputAction.next,
                                      onChanged: notifier.setPrice,
                                      validator: AppValidators.emptyCheck,
                                      inputFormatters: [
                                        InputFormatter.currency
                                      ],
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
                                            MediaQuery.sizeOf(context).height /
                                                2,
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                3,
                                        child: const MultiSelectionWidget(
                                            isEdit: true),
                                      ));
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
                                          AppHelpers.getTranslation(
                                              TrKeys.select),
                                          style: Style.interNormal(
                                              size: 14, color: Style.colorGrey),
                                        )
                                      : ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.stocks.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
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
                                              (BuildContext context,
                                                  int index) {
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
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    notifier.updateDiscount(context, updated: () {
                                      ref
                                          .read(discountProvider.notifier)
                                          .fetchDiscounts(
                                              context: context,
                                              isRefresh: true);
                                       context.maybePop();
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
