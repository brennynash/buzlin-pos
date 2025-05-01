import 'package:admin_desktop/application/catalogue/catalogue_provider.dart';
import 'package:admin_desktop/application/masters/edit/edit_masters_provider.dart';
import 'package:admin_desktop/application/product/product_provider.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/catalogue/widgets/masters/edit_master_page.dart';
import 'package:admin_desktop/presentation/theme/theme/theme_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../styles/style.dart';
import '../menu/widgets/sections_item.dart';
import '../product/product_page.dart';
import 'widgets/masters/masters_page.dart';
import 'widgets/service/add_service/add_service_page.dart';
import 'widgets/service/edit_service/edit_service_page.dart';
import 'widgets/service/service_page.dart';
import 'widgets/service_master/add_service_master/add_service_master_page.dart';
import 'widgets/service_master/edit_service_master/edit_service_master_page.dart';
import 'widgets/service_master/service_master_page.dart';

class CataloguePage extends ConsumerWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(catalogueProvider);
    final notifier = ref.read(catalogueProvider.notifier);
    final productState = ref.watch(productProvider);
    final productNotifier = ref.watch(productProvider.notifier);
    return ThemeWrapper(builder: (colors, controller) {
      return Row(
        children: [
          ///LEFTSIDE
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.horizontalSpace,
              if (state.isCatalogueOpen)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionsItem(
                      isActive:
                          productState.stateIndex == 4 && state.stateIndex == 0,
                      onTap: () {
                        notifier.changeState(0);
                        productNotifier.changeState(4);
                      },
                      title: AppHelpers.getTranslation(TrKeys.products),
                      icon: Remix.box_1_line,
                    ),
                    SectionsItem(
                      isActive:
                          productState.stateIndex == 0 && state.stateIndex == 0,
                      onTap: () {
                        notifier.changeState(0);
                        productNotifier.changeState(0);
                      },
                      title: AppHelpers.getTranslation(TrKeys.categories),
                      icon: Remix.layout_grid_line,
                    ),
                    SectionsItem(
                      isActive:
                          productState.stateIndex == 3 && state.stateIndex == 0,
                      onTap: () {
                        notifier.changeState(0);
                        productNotifier.changeState(3);
                      },
                      title: AppHelpers.getTranslation(TrKeys.brands),
                      icon: Remix.gradienter_line,
                    ),
                    SectionsItem(
                      isActive: state.stateIndex == 1,
                      onTap: () {
                        notifier.changeState(1);
                      },
                      title: AppHelpers.getTranslation(TrKeys.masters),
                      icon: Remix.group_line,
                    ),
                    SectionsItem(
                      isActive: state.stateIndex == 2,
                      onTap: () {
                        notifier.changeState(2);
                      },
                      title: AppHelpers.getTranslation(TrKeys.service),
                      icon: Remix.scissors_line,
                    ),
                    SectionsItem(
                      isActive: state.stateIndex == 3,
                      onTap: () {
                        notifier.changeState(3);
                      },
                      title: AppHelpers.getTranslation(TrKeys.serviceToMasters),
                      icon: Remix.scissors_2_line,
                    ),
                  ],
                ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: IntrinsicHeight(
                      child: state.isCatalogueOpen
                          ? const VerticalDivider(color: Style.colorGrey)
                          : const SizedBox.shrink(),
                    ),
                  ),
                  CircleButton(
                    icon: state.isCatalogueOpen
                        ? Remix.arrow_left_s_line
                        : Remix.arrow_right_s_line,
                    onTap: notifier.toggleCatalogue,
                    backgroundColor: Style.white,
                    isBorder: true,
                  ),
                  if (state.isCatalogueOpen)
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
                ? const ProductPage(
                    isCatalog: true,
                  )
                : state.stateIndex == 1
                    ? const MastersPage()
                    : state.stateIndex == 2
                        ? const ServicePage()
                        : state.stateIndex == 3
                            ? const ServiceMasterPage()
                            : state.stateIndex == 4
                                ? const AddServicePage()
                                : state.stateIndex == 5
                                    ? const EditServicePage()
                                    : state.stateIndex == 6
                                        ? const AddServiceMasterPage()
                                        : state.stateIndex == 7
                                            ? const EditServiceMasterPage()
                                            : EditMasterPage(
                                                state: ref
                                                    .watch(editMastersProvider),
                                                notifier: notifier,
                                                editMasterNotifier: ref.read(
                                                    editMastersProvider
                                                        .notifier)),
          )
        ],
      );
    });
  }
}
