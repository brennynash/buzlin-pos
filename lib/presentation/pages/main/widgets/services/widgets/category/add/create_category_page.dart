import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import '../../../../../../../../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import 'create_category_left.dart';
import 'create_category_right.dart';
import 'riverpod/create_service_category_provider.dart';

class CreateServiceCategoryPage extends ConsumerStatefulWidget {
  const CreateServiceCategoryPage({super.key});

  @override
  ConsumerState<CreateServiceCategoryPage> createState() =>
      _CreateServiceCategoryPageState();
}

class _CreateServiceCategoryPageState
    extends ConsumerState<CreateServiceCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(foodCategoriesProvider.notifier)
          .fetchCategories(context: context);
      ref.read(createServiceCategoryProvider.notifier).clear();
      ref.read(languagesProvider.notifier).getLanguages(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createServiceCategoryProvider);
    final notifier = ref.read(createServiceCategoryProvider.notifier);
    final langState = ref.watch(languagesProvider);

    return KeyboardDisable(
      child: CustomScaffold(
        body: (colors) => Column(
          children: [
            Expanded(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.verticalSpace,
                        Row(
                          children: [
                            CustomBackButton(
                              onTap: () => ref
                                  .read(servicesProvider.notifier)
                                  .changeState(0),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Style.white,
                              ),
                              width: 200,
                              child: PopupMenuButton<LanguageData>(
                                onOpened: () {
                                  notifier.setDesc();
                                },
                                splashRadius: 12.r,
                                itemBuilder: (context) {
                                  return langState.languages.map((langItem) {
                                    return PopupMenuItem<LanguageData>(
                                      value: langItem,
                                      child: Text(
                                        langItem.title ?? "",
                                        style: Style.interMedium(),
                                      ),
                                    );
                                  }).toList();
                                },
                                onSelected: (selectedLanguage) {
                                  notifier.setLanguage(selectedLanguage);
                                  notifier.setTitleAndDescState(
                                      selectedLanguage.locale ?? "en");
                                },
                                child: SelectFromButton(
                                  title: AppHelpers.getTranslation(
                                      state.language?.title ?? ""),
                                ),
                              ),
                            ),
                            20.horizontalSpace,
                          ],
                        ),
                        24.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: CreateCategoryLeft(
                                  notifier: notifier,
                                  state: state,
                                )),
                            Expanded(
                                flex: 1,
                                child: CreateCategoryRight(
                                  notifier: notifier,
                                  state: state,
                                ))
                          ],
                        ),
                        24.verticalSpace,
                        CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.save),
                          isLoading: state.isLoading,
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              notifier
                                ..setDesc()
                                ..createCategory(
                                  context,
                                  type: 'service',
                                  //parentId: categoryState.selectCategory?.id,
                                  created: () {
                                    ref
                                        .read(foodCategoriesProvider.notifier)
                                        .fetchCategories(context: context);
                                    ref
                                        .read(productProvider.notifier)
                                        .changeState(0);
                                  },
                                );
                            }
                          },
                        ),
                      ],
                    ),
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
