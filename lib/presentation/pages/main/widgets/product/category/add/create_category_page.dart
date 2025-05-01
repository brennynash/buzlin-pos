import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'create_category_left.dart';
import 'create_category_right.dart';

class CreateCategoryPage extends ConsumerStatefulWidget {
  const CreateCategoryPage({super.key});

  @override
  ConsumerState<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends ConsumerState<CreateCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(foodCategoriesProvider.notifier)
          .fetchCategories(context: context);
      ref.read(createCategoryProvider.notifier).clear();
      ref
          .read(createCategoryParentProvider.notifier)
          .setCategories(ref.watch(foodCategoriesProvider).categories);
      ref.read(languagesProvider.notifier).getLanguages(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createCategoryProvider);
    final notifier = ref.read(createCategoryProvider.notifier);
    final categoryState = ref.watch(createCategoryParentProvider);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      24.verticalSpace,
                      Row(
                        children: [
                          CustomBackButton(
                            onTap: () => ref
                                .read(productProvider.notifier)
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
                                  categoryNotifier: ref.read(
                                      createCategoryParentProvider.notifier),
                                  categoryState: categoryState,
                                  state: state)),
                          Expanded(
                              flex: 1,
                              child: CreateCategoryRight(
                                  state: state, notifier: notifier))
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
                                type: categoryState.selectCategories.length == 1
                                    ? "sub_main"
                                    : categoryState.selectCategories.length == 2
                                        ? TrKeys.child
                                        : TrKeys.main,
                                parentId: categoryState.selectCategory?.id,
                                created: () {
                                  state.titleController?.clear();
                                  state.descriptionController?.clear();
                                  ref
                                      .read(foodCategoriesProvider.notifier)
                                      .initialFetchCategories();
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
          ],
        ),
      ),
    );
  }
}
