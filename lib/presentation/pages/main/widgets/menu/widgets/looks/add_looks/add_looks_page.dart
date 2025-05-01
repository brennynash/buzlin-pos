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
import '../widgets/product_multi_selection.dart';

class AddLooksPage extends ConsumerStatefulWidget {
  const AddLooksPage({super.key});

  @override
  ConsumerState<AddLooksPage> createState() => _AddLooksPageState();
}

class _AddLooksPageState extends ConsumerState<AddLooksPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;

  @override
  void initState() {
    title = TextEditingController();
    desc = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(addLooksProvider.notifier).clear());
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Scaffold(
        backgroundColor: Style.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderItem(title: TrKeys.addLooks),
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(addLooksProvider);
                    final notifier = ref.read(addLooksProvider.notifier);
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Row(
                            children: [
                              SingleImagePicker(
                                height: MediaQuery.sizeOf(context).height / 6,
                                width: MediaQuery.sizeOf(context).height / 6,
                                imageFilePath: state.imageFile,
                                onImageChange: notifier.setImageFile,
                                onDelete: () => notifier.setImageFile(null),
                              ),
                              24.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppHelpers.getTranslation(TrKeys.status),
                                      style: Style.interNormal(),
                                    ),
                                    CustomToggle(
                                      controller: ValueNotifier(state.active),
                                      onChange: (c) =>
                                          notifier.setActive(!(state.active)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          16.verticalSpace,
                          OutlinedBorderTextField(
                            label:
                                '${AppHelpers.getTranslation(TrKeys.title)}*',
                            textInputAction: TextInputAction.next,
                            textController: title,
                            validator: AppValidators.emptyCheck,
                          ),
                          12.verticalSpace,
                          OutlinedBorderTextField(
                            label:
                                AppHelpers.getTranslation(TrKeys.description),
                            textInputAction: TextInputAction.next,
                            textController: desc,
                          ),
                          16.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              AppHelpers.showAlertDialog(
                                  context: context,
                                  child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              1.5,
                                      width: MediaQuery.sizeOf(context).width /
                                          3.5,
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
                              child: state.products.isEmpty
                                  ? Text(
                                      AppHelpers.getTranslation(TrKeys.select),
                                      style: Style.interNormal(
                                          size: 14, color: Style.textHint),
                                    )
                                  : ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.products.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Chip(
                                          backgroundColor: Style.primary,
                                          deleteIcon: Icon(
                                            Remix.close_circle_fill,
                                            size: 20.r,
                                            color: Style.white,
                                          ),
                                          onDeleted: () {
                                            notifier.deleteFromAddedProducts(
                                                state.products[index].id);
                                          },
                                          label: Text(
                                            state.products[index].translation
                                                    ?.title ??
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
                                notifier.createLooks(
                                  context,
                                  created: (look) {
                                    //widget.onSave();
                                    AppHelpers.showSnackBar(
                                      context,
                                      AppHelpers.getTranslation(
                                          TrKeys.successfullyCreated),
                                    );
                                    ref.read(looksProvider.notifier).fetchLooks(
                                        context: context, isRefresh: true);
                                    context.maybePop();
                                  },
                                  onError: () {},
                                  title: title.text,
                                  description: desc.text,
                                );
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
