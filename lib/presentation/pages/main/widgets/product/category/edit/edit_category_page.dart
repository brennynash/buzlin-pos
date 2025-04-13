import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'edit_category_left.dart';
import 'edit_category_right.dart';

class EditCategoryPage extends ConsumerStatefulWidget {
  const EditCategoryPage({super.key});

  @override
  ConsumerState<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends ConsumerState<EditCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(foodCategoriesProvider.notifier)
          .fetchCategories(context: context);
      ref
          .read(editCategoryParentProvider.notifier)
          .setCategories(ref.watch(foodCategoriesProvider).categories);
      ref.read(languagesProvider.notifier).getLanguages(context);
      ref
          .read(editCategoryProvider.notifier)
          .setLanguage(LocalStorage.getLanguage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langState = ref.watch(languagesProvider);
    final state = ref.watch(editCategoryProvider);
    final notifier = ref.read(editCategoryProvider.notifier);
    final categoryState = ref.watch(editCategoryParentProvider);
    return KeyboardDisable(
      child: CustomScaffold(
        body: (colors) => Column(
          children: [
            Expanded(
              child: state.isLoading
                  ? const Center(child: Loading())
                  : Padding(
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
                                        return langState.languages
                                            .map((langItem) {
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
                                    child: EditCategoryLeft(
                                      notifier: notifier,
                                      state: state,
                                      categoryState: categoryState,
                                      categoryNotifier: ref.read(
                                          editCategoryParentProvider.notifier),
                                    ),
                                  ),
                                  Expanded(
                                    child: EditCategoryRight(
                                      notifier: notifier,
                                      state: state,
                                    ),
                                  )
                                ],
                              ),
                              24.verticalSpace,
                              CustomButton(
                                title: AppHelpers.getTranslation(TrKeys.save),
                                isLoading: state.isLoading,
                                onTap: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    notifier
                                      ..setDesc()
                                      ..updateCategory(
                                        context,
                                        type: categoryState
                                                    .selectCategories.length ==
                                                1
                                            ? "sub_main"
                                            : categoryState.selectCategories
                                                        .length ==
                                                    2
                                                ? TrKeys.child
                                                : TrKeys.main,
                                        parentId:
                                            categoryState.selectCategory?.id,
                                        updated: () {
                                          ref
                                              .read(foodCategoriesProvider
                                                  .notifier)
                                              .fetchCategories(
                                                  context: context);
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
