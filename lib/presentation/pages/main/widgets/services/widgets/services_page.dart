import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import '../../menu/widgets/looks/looks_page.dart';
import '../../menu/widgets/sections_item.dart';
import '../../schedule/schedule_page.dart';
import 'category/add/create_category_page.dart';
import 'category/edit/edit_category_page.dart';
import 'category/riverpod/service_categories_provider.dart';
import 'category/widgets/category_list_view.dart';

class ServicePage extends ConsumerStatefulWidget {
  const ServicePage({super.key});

  @override
  ConsumerState<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) =>
          ref.read(serviceCategoriesProvider.notifier).initialFetchCategories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(servicesProvider);
    final notifier = ref.read(servicesProvider.notifier);
    return ColoredBox(
      color: Style.white,
      child: Row(
        children: [
          ///LEFTSIDE
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.horizontalSpace,
              if (state.isServicesOpen)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionsItem(
                      onTap: () {
                        AppHelpers.showAlertDialog(
                          context: context,
                          backgroundColor: Style.bg,
                          child: SizedBox(
                              height: MediaQuery.sizeOf(context).height / 1.5,
                              width: MediaQuery.sizeOf(context).width / 2,
                              child: const LooksPage()),
                        );
                      },
                      title: AppHelpers.getTranslation(TrKeys.services),
                      icon: Remix.scissors_cut_line,
                    ),
                    SectionsItem(
                      onTap: () {
                        notifier.changeState(3);
                        // AppHelpers.showAlertDialog(
                        //   context: context,
                        //   backgroundColor: Style.bg,
                        //   child: SizedBox(
                        //       height: MediaQuery.sizeOf(context).height / 1.5,
                        //       width: MediaQuery.sizeOf(context).width / 2,
                        //       child: const SchedulePage()),
                        // );
                      },
                      title: AppHelpers.getTranslation(TrKeys.schedule),
                      icon: Remix.calendar_event_line,
                    ),
                  ],
                ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: IntrinsicHeight(
                      child: state.isServicesOpen
                          ? const VerticalDivider(color: Style.colorGrey)
                          : const SizedBox.shrink(),
                    ),
                  ),
                  CircleButton(
                    icon: state.isServicesOpen
                        ? Remix.arrow_left_s_line
                        : Remix.arrow_right_s_line,
                    onTap: notifier.toggleServices,
                    backgroundColor: Style.white,
                    isBorder: true,
                  ),
                  if (state.isServicesOpen)
                    const Expanded(
                        child: IntrinsicHeight(
                            child: VerticalDivider(
                      color: Style.colorGrey,
                    ))),
                ],
              ),
            ],
          ),

          ///RIGHTSIDE
          Expanded(
            child: state.stateIndex == 0
                ? const CategoryListView()
                : state.stateIndex == 1
                    ? const CreateServiceCategoryPage()
                    : state.stateIndex == 2
                        ? const EditServiceCategoryPage()
                        : state.stateIndex == 3
                            ? const SchedulePage()
                            : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
