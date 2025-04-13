import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/presentation/theme/theme/theme.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/comments/widgets/no_item.dart';
import 'riverpod/service/edit/edit_service_provider.dart';
import 'riverpod/service/service_provider.dart';
import 'widgets/service_item.dart';

class ServicePage extends ConsumerStatefulWidget {
  const ServicePage({super.key});

  @override
  ConsumerState<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage> {
  late RefreshController refreshController;

  @override
  void initState() {
    refreshController = RefreshController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref
            .read(serviceProvider.notifier)
            .fetchAllServices(context: context, isRefresh: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceProvider);
    final notifier = ref.read(serviceProvider.notifier);
    return Directionality(
      textDirection:
          LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
      child: CustomScaffold(
        body: (CustomColorSet colors) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.service),
                    style: Style.interMedium(size: 20),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LoginButton(
                      bgColor: Style.black,
                      icon: Icon(
                        Remix.add_circle_line,
                        color: Style.white,
                        size: 24.r,
                      ),
                      onPressed: () {
                        ref.read(catalogueProvider.notifier).changeState(4);
                      },
                      title: AppHelpers.getTranslation(TrKeys.addService),
                    ),
                  )
                ],
              ),
              Expanded(
                child: state.isLoading
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 72,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  color: Style.shimmerBase,
                                ),
                              ),
                              const Divider(height: 2, color: Style.white),
                            ],
                          );
                        })
                    : state.allServices.isEmpty
                        ? const NoItem(title: TrKeys.noService)
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  runSpacing: 12,
                                  spacing: 12,
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    ...state.allServices.mapIndexed(
                                      (e, i) => ServiceItem(
                                        service: e,
                                        onTap: () {
                                          ref
                                              .read(
                                                  editServiceProvider.notifier)
                                              .setDetails(
                                                state.allServices[i],
                                              )
                                              .then((v) => ref
                                                  .read(catalogueProvider
                                                      .notifier)
                                                  .changeState(5));
                                        },
                                        onDelete: () {
                                          ref
                                              .read(serviceProvider.notifier)
                                              .deleteService(context,
                                                  state.allServices[i].id);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                if (state.hasMore)
                                  HasMoreButton(
                                    hasMore: state.hasMore,
                                    onViewMore: () {
                                      notifier.fetchAllServices(
                                          context: context);
                                    },
                                  )
                              ],
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
