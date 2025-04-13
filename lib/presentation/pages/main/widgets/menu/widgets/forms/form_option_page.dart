import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/menu/widgets/forms/add/add_form_page.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/menu/widgets/forms/edit/edit_form_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../components/delete_modal.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../comments/widgets/no_item.dart';
import 'widget/form_option_item.dart';

class FormOptionPage extends ConsumerStatefulWidget {
  const FormOptionPage({super.key});

  @override
  ConsumerState<FormOptionPage> createState() => _FormOptionPageState();
}

class _FormOptionPageState extends ConsumerState<FormOptionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(formProvider.notifier).fetchForms(isRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(formProvider);
            final notifier = ref.read(formProvider.notifier);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeaderItem(title: TrKeys.form),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: Loading())
                      : state.list.isEmpty
                          ? const NoItem(
                              title: TrKeys.noForm,
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.list.length,
                                    padding: REdgeInsets.all(12),
                                    itemBuilder: (context, index) {
                                      return FormOptionItem(
                                        form: state.list[index],
                                        onEdit: () {
                                          AppHelpers.showAlertDialog(
                                              context: context,
                                              child: SizedBox(
                                                height: 0.67.sh,
                                                width: 0.5.sw,
                                                child: EditFormPage(
                                                    formOption:
                                                        state.list[index]),
                                              ));
                                        },
                                        onDelete: () {
                                          AppHelpers.showCustomModalBottomSheet(
                                            context: context,
                                            modal: DeleteModal(
                                              onDelete: () {
                                                notifier.deleteForm(
                                                  context,
                                                  state.list[index].id,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  HasMoreButton(
                                      hasMore: state.hasMore,
                                      onViewMore: () =>
                                          notifier.fetchForms(context: context))
                                ],
                              ),
                            ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppHelpers.showAlertDialog(
                context: context,
                child: SizedBox(
                  height: 0.67.sh,
                  width: 0.5.sw,
                  child: const AddFormPage(),
                ));
            //notifier.addTextField();
          },
          backgroundColor: Style.primary,
          child: const Icon(Remix.add_fill),
        ),
      ),
    );
  }
}
