import 'package:admin_desktop/application/profile/profile_notifier.dart';
import 'package:admin_desktop/application/shop/shop_notifier.dart';
import 'package:admin_desktop/application/shop/shop_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'widget/delivery_time.dart';

class EditShop extends StatefulWidget {
  final ShopNotifier notifier;
  final ShopState state;
  final ProfileNotifier profileNotofier;

  const EditShop(
      {super.key,
      required this.notifier,
      required this.state,
      required this.profileNotofier});

  @override
  State<EditShop> createState() => _EditShopState();
}

class _EditShopState extends State<EditShop> {
  List<ValueItem> selectedType = [];
  List<ValueItem> selectedCategory = [];
  List<ValueItem> selectedTag = [];
  List<ValueItem> categoryItem = [];
  List<ValueItem> tagItem = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (widget.state.isUpdate) {
          widget.notifier.fetchShopData(onSuccess: () {
            widget.state.categories?.data?.forEach((element) {
              categoryItem.add(ValueItem(
                  label: element.translation?.title ?? "",
                  value: element.id.toString()));
            });

            widget.state.tag?.data?.forEach((element) {
              tagItem.add(ValueItem(
                  label: element.translation?.title ?? "",
                  value: element.id.toString()));
            });
          });
        } else {
          widget.state.categories?.data?.forEach((element) {
            categoryItem.add(ValueItem(
                label: element.translation?.title ?? "",
                value: element.id.toString()));
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final notifier = ref.read(rightSideProvider.notifier);
    // final state = ref.watch(rightSideProvider);
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 18, right: 18),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Style.white,
            ),
            child: widget.state.isEditShopData
                ? const Center(child: Loading())
                : SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppHelpers.getTranslation(
                                      TrKeys.logoImage)),
                                  8.verticalSpace,
                                  CustomEditWidget(
                                      isLoading:
                                          widget.state.isLogoImageLoading,
                                      height: 140,
                                      width: 140,
                                      radius: 16,
                                      image:
                                          widget.state.editShopData?.logoImg ??
                                              "",
                                      imagePath: widget.state.logoImagePath,
                                      isEmptyorNot:
                                          widget.state.logoImagePath.isEmpty,
                                      isEmptyorNot2:
                                          widget.state.logoImagePath.isNotEmpty,
                                      localStoreImage:
                                          widget.state.editShopData?.logoImg ??
                                              "",
                                      onthisTap: () {
                                        widget.notifier.getPhoto(
                                            isLogoImage: true,
                                            context: context);
                                      }),
                                ],
                              ),
                              40.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppHelpers.getTranslation(
                                      TrKeys.backgroundImage)),
                                  8.verticalSpace,
                                  CustomEditWidget(
                                      isLoading:
                                          widget.state.isBackImageLoading,
                                      height: 140,
                                      width:
                                          (MediaQuery.sizeOf(context).width) /
                                              3,
                                      radius: 16,
                                      image: widget.state.editShopData
                                              ?.backgroundImg ??
                                          "",
                                      imagePath: widget.state.backImagePath,
                                      isEmptyorNot:
                                          widget.state.backImagePath.isEmpty,
                                      isEmptyorNot2:
                                          widget.state.backImagePath.isNotEmpty,
                                      localStoreImage: widget.state.editShopData
                                              ?.backgroundImg ??
                                          "",
                                      onthisTap: () {
                                        widget.notifier
                                            .getPhoto(context: context);
                                      }),
                                ],
                              ),
                              const Spacer(),
                              ConfirmButton(
                                  isActive: false,
                                  isTab: true,
                                  title:
                                      widget.state.editShopData?.status ?? "",
                                  onTap: () {})
                            ],
                          ),
                          16.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.generalInfo),
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 22),
                          ),
                          16.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    OutlinedBorderTextField(
                                      initialText: widget.state.editShopData
                                          ?.translation?.title,
                                      validator: AppValidators.emptyCheck,
                                      label: AppHelpers.getTranslation(
                                          TrKeys.title),
                                      onChanged: widget.notifier.setTitle,
                                    ),
                                    12.verticalSpace,
                                    OutlinedBorderTextField(
                                      validator: AppValidators.emptyCheck,
                                      initialText:
                                          widget.state.editShopData?.phone,
                                      label: AppHelpers.getTranslation(
                                          TrKeys.phone),
                                      onChanged: widget.notifier.setPhone,
                                    ),
                                    12.verticalSpace,
                                    OutlinedBorderTextField(
                                      validator: AppValidators.emptyCheck,
                                      initialText: widget.state.editShopData
                                          ?.translation?.address,
                                      label: AppHelpers.getTranslation(
                                          TrKeys.address),
                                      onChanged: (c) {},
                                      onTap: () =>
                                          widget.profileNotofier.changeIndex(2),
                                    ),
                                  ],
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  children: [
                                    OutlinedBorderTextField(
                                      initialText: widget.state.editShopData
                                          ?.translation?.description,
                                      onChanged: widget.notifier.setDescription,
                                      minLine: 8,
                                      label: AppHelpers.getTranslation(
                                          TrKeys.description),
                                    ),
                                    DropdownButtonFormField(
                                      value: LocalStorage.getShop()
                                                  ?.deliveryType ==
                                              1
                                          ? TrKeys.inHouse
                                          : LocalStorage.getShop()
                                                      ?.deliveryType ==
                                                  2
                                              ? TrKeys.ownSeller
                                              : null,
                                      items: DropDownValues.deliveryTypeList
                                          .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                  AppHelpers.getTranslation(
                                                      e))))
                                          .toList(),
                                      onChanged: (s) {
                                        if (s != null) {
                                          widget.notifier
                                              .setDeliveryType(s.toString());
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        labelText: AppHelpers.getTranslation(
                                            TrKeys.deliveryType),
                                        labelStyle: Style.interNormal(
                                          size: 12,
                                          color: Style.black,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.merge(
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor),
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor))),
                                        errorBorder: InputBorder.none,
                                        border: const UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            const UnderlineInputBorder(),
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.merge(
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor),
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor))),
                                        focusedBorder:
                                            const UnderlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          18.verticalSpace,
                          const Divider(),
                          18.verticalSpace,
                          Row(
                            children: [
                              Text(
                                AppHelpers.getTranslation(
                                    TrKeys.shippingInformation),
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600, fontSize: 22),
                              ),
                              const Spacer(),
                            ],
                          ),
                          18.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  OutlinedBorderTextField(
                                    inputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: AppValidators.isNumberValidator,
                                    initialText: widget.state.editShopData
                                            ?.deliveryTime?.from ??
                                        "0",
                                    label: AppHelpers.getTranslation(
                                        TrKeys.deliveryTimeFrom),
                                    onChanged: widget.notifier.setFrom,
                                  ),
                                  12.verticalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(AppHelpers.getTranslation(
                                          TrKeys.deliveryTimeType)),
                                      4.verticalSpace,
                                      MultiSelectDropDown(
                                        hintStyle:
                                            const TextStyle(fontSize: 16),
                                        borderColor: Style.borderColor,
                                        borderRadius: 10,
                                        onOptionSelected:
                                            (List<ValueItem> selectedOptions) {
                                          selectedType = selectedOptions;
                                        },
                                        options: [
                                          ValueItem(
                                              label: AppHelpers.getTranslation(
                                                  TrKeys.hour),
                                              value: "hour"),
                                          ValueItem(
                                              label: AppHelpers.getTranslation(
                                                  TrKeys.minut),
                                              value: "minute")
                                        ],
                                        selectionType: SelectionType.single,
                                        dropdownHeight: 220.h,
                                        optionTextStyle:
                                            const TextStyle(fontSize: 16),
                                        selectedOptionIcon:
                                            const Icon(Icons.check_circle),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                              12.horizontalSpace,
                              Expanded(
                                  child: Column(
                                children: [
                                  OutlinedBorderTextField(
                                    inputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: AppValidators.isNumberValidator,
                                    initialText: widget.state.editShopData
                                            ?.deliveryTime?.to ??
                                        "0",
                                    label: AppHelpers.getTranslation(
                                        TrKeys.deliveryTimeTo),
                                    onChanged: widget.notifier.setTo,
                                  ),
                                  // 12.verticalSpace,
                                  // OutlinedBorderTextField(
                                  //   inputType: TextInputType.number,
                                  //   inputFormatters: [
                                  //     FilteringTextInputFormatter.digitsOnly
                                  //   ],
                                  //   validator: AppValidators.emptyCheck,
                                  //   initialText:
                                  //       (state.editShopData?.minAmount ?? 0)
                                  //           .toString(),
                                  //   label: AppHelpers.getTranslation(
                                  //       TrKeys.minAmount),
                                  //   onChanged: notifier.setAmount,
                                  // ),
                                  12.verticalSpace,
                                  OutlinedBorderTextField(
                                    inputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: AppValidators.emptyCheck,
                                    initialText:
                                        (widget.state.editShopData?.tax ?? 0)
                                            .toString(),
                                    label:
                                        AppHelpers.getTranslation(TrKeys.tax),
                                    onChanged: widget.notifier.setTax,
                                  ),
                                ],
                              )),
                            ],
                          ),
                          DeliveryTimeWidget(
                            selectedCategory: selectedCategory,
                            selectedTag: selectedTag,
                            selectedType: selectedType,
                            formKey: _formKey,
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
