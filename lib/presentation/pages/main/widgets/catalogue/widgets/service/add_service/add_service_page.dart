import 'package:admin_desktop/domain/models/data/category_data.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import '../../../../../../../theme/theme/theme.dart';
import '../riverpod/service/add/add_service_provider.dart';
import '../riverpod/service/service_provider.dart';
import '../widgets/service_categories_modal.dart';

class AddServicePage extends ConsumerStatefulWidget {
  const AddServicePage({super.key});

  @override
  ConsumerState<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends ConsumerState<AddServicePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;
  late TextEditingController pause;
  late TextEditingController price;
  late TextEditingController interval;
  late TextEditingController category;
  CategoryData? selectCategory;

  @override
  void initState() {
    title = TextEditingController();
    desc = TextEditingController();
    pause = TextEditingController();
    price = TextEditingController();
    interval = TextEditingController();
    category = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(addServiceProvider.notifier).clear());
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    pause.dispose();
    price.dispose();
    interval.dispose();
    category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addServiceProvider);
    final notifier = ref.read(addServiceProvider.notifier);
    return KeyboardDisable(
      child: CustomScaffold(
        body: (CustomColorSet colors) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(
                    onPressed: () {
                      ref.read(catalogueProvider.notifier).changeState(2);
                    },
                  ),
                  20.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.addServiceToMaster),
                    style: Style.interMedium(size: 20),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        16.verticalSpace,
                        MultiImagePicker(
                          imageUrls: state.listOfUrls,
                          listOfImages: state.images,
                          onImageChange: notifier.setImageFile,
                          onDelete: notifier.deleteImage,
                          isExtras: true,
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          label: '${AppHelpers.getTranslation(TrKeys.title)}*',
                          textInputAction: TextInputAction.next,
                          textController: title,
                          validator: AppValidators.emptyCheck,
                        ),
                        12.verticalSpace,
                        OutlinedBorderTextField(
                          label: AppHelpers.getTranslation(TrKeys.description),
                          textInputAction: TextInputAction.next,
                          textController: desc,
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          readOnly: true,
                          onTap: () {
                            AppHelpers.showAlertDialog(
                              context: context,
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height / 1.5,
                                width: MediaQuery.sizeOf(context).width / 2,
                                child: ServiceCategoriesModal(
                                  onChange: (value) {
                                    selectCategory = value;
                                    category.text =
                                        value.translation?.title ?? '';
                                  },
                                ),
                              ),
                            );
                          },
                          label:
                              "${AppHelpers.getTranslation(TrKeys.category)}*",
                          textInputAction: TextInputAction.next,
                          validator: AppValidators.emptyCheck,
                          textController: category,
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          label:
                              '${AppHelpers.getTranslation(TrKeys.interval)}*',
                          textInputAction: TextInputAction.next,
                          textController: interval,
                          validator: AppValidators.isNumberValidator,
                          inputFormatters: [InputFormatter.digitsOnly],
                          inputType: TextInputType.number,
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          label: '${AppHelpers.getTranslation(TrKeys.pause)}*',
                          textInputAction: TextInputAction.next,
                          textController: pause,
                          validator: AppValidators.isNumberValidator,
                          inputFormatters: [InputFormatter.digitsOnly],
                          inputType: TextInputType.number,
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          label: '${AppHelpers.getTranslation(TrKeys.price)}*',
                          textInputAction: TextInputAction.next,
                          textController: price,
                          inputType: TextInputType.number,
                          validator: AppValidators.emptyCheck,
                          inputFormatters: [InputFormatter.currency],
                        ),
                        16.verticalSpace,
                        OutlineDropDown(
                          label: TrKeys.type,
                          hint: TrKeys.type,
                          list: DropDownValues.serviceTypeList,
                          onChanged: notifier.setType,
                        ),
                        16.verticalSpace,
                        OutlineDropDown(
                          label: TrKeys.gender,
                          hint: TrKeys.gender,
                          list: DropDownValues.genderList,
                          onChanged: notifier.setGender,
                        ),
                        60.verticalSpace,
                        CustomButton(
                          textColor: Style.white,
                          // radius: 45,
                          title: AppHelpers.getTranslation(TrKeys.save),
                          isLoading: state.isLoading,
                          onTap: () {
                            if (state.images.isEmpty) {
                              AppHelpers.errorSnackBar(context,
                                  text: TrKeys.imageCantEmpty);
                              return;
                            }
                            if ((_formKey.currentState?.validate() ?? false) &&
                                selectCategory?.id != null) {
                              notifier.createService(
                                context,
                                created: (service) {
                                  AppHelpers.showSnackBar(
                                    context,
                                    AppHelpers.getTranslation(
                                        TrKeys.successfullyCreated),
                                  );
                                  ref
                                      .read(serviceProvider.notifier)
                                      .fetchAllServices(
                                          context: context, isRefresh: true);
                                  context.maybePop();
                                },
                                onError: () {},
                                title: title.text,
                                description: desc.text,
                                price: price.text,
                                interval: interval.text,
                                pause: pause.text,
                                categoryId: selectCategory!.id!,
                              );
                            }
                          },
                        ),
                        60.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
