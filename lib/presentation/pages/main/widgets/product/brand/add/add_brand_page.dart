import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class AddBrandPage extends ConsumerStatefulWidget {
  const AddBrandPage({super.key});

  @override
  ConsumerState<AddBrandPage> createState() => _AddBrandPageState();
}

class _AddBrandPageState extends ConsumerState<AddBrandPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(addBrandProvider.notifier);
    final state = ref.watch(addBrandProvider);
    return CustomScaffold(
      body: (colors) => state.isInitial
          ? const Loading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    12.verticalSpace,
                    Row(
                      children: [
                        CustomBackButton(
                            onTap: () => ref
                                .read(productProvider.notifier)
                                .changeState(3)),
                      ],
                    ),
                    6.verticalSpace,
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: Style.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.image),
                                    style: Style.interRegular(size: 16.sp),
                                  ),
                                  8.verticalSpace,
                                  SingleImagePicker(
                                    isAdding: state.brandData?.img == null,
                                    imageFilePath: state.imageFile,
                                    imageUrl: state.brandData?.img,
                                    onImageChange: notifier.setImageFile,
                                    onDelete: () => notifier.setImageFile(null),
                                  ),
                                ],
                              ),
                              24.horizontalSpace,
                              Padding(
                                padding: REdgeInsets.only(top: 8),
                                child: SizedBox(
                                  width: (MediaQuery.sizeOf(context).width -
                                          140.w) /
                                      3,
                                  child: OutlinedBorderTextField(
                                    label:
                                        "${AppHelpers.getTranslation(TrKeys.title)}*",
                                    inputType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textInputAction: TextInputAction.next,
                                    onChanged: notifier.setTitle,
                                    initialText: state.brandData?.title,
                                    validator: AppValidators.emptyCheck,
                                  ),
                                ),
                              ),
                              24.horizontalSpace,
                              Column(
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.active),
                                    style: Style.interRegular(size: 16.sp),
                                  ),
                                  12.verticalSpace,
                                  CustomToggle(
                                    controller: ValueNotifier(state.active),
                                    onChange: notifier.changeActive,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
      floatingActionButton: (c) => SizedBox(
        width: 150.r,
        child: LoginButton(
          isLoading: state.isLoading,
            title: AppHelpers.getTranslation(
                state.brandData == null ? TrKeys.save : TrKeys.update),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {

                if (state.brandData == null) {
                  if(state.imageFile?.isEmpty ?? true){
                    AppHelpers.showSnackBar(context, AppHelpers.getTranslation(TrKeys.uploadImage));
                    return;
                  }
                  notifier.createBrand(context, created: (brand) {
                    ref.read(brandProvider.notifier).setAllBrands(brand);
                    ref.read(brandProvider.notifier).fetchAllBrands(context: context,isRefresh: true);
                    ref.read(productProvider.notifier).changeState(3);
                  });
                } else {
                  notifier.updateBrand(context, created: (brand) {
                    ref.read(brandProvider.notifier).setAllBrands(brand);
                    ref.read(brandProvider.notifier).fetchAllBrands(context: context,isRefresh: true);
                    ref.read(productProvider.notifier).changeState(3);
                  });
                }
              }
            }),
      ),
    );
  }
}
