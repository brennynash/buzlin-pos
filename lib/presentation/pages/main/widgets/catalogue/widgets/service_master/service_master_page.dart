import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/presentation/theme/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../comments/widgets/no_item.dart';
import 'riverpod/service_master/edit/edit_service_master_provider.dart';
import 'riverpod/service_master/service_master_provider.dart';
import 'widgets/service_master_item.dart';

class ServiceMasterPage extends ConsumerStatefulWidget {
  const ServiceMasterPage({super.key});

  @override
  ConsumerState<ServiceMasterPage> createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServiceMasterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref
            .read(serviceMasterProvider.notifier)
            .fetchServices(context: context, isRefresh: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceMasterProvider);
    final notifier = ref.read(serviceMasterProvider.notifier);
    return Directionality(
      textDirection:
          LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
      child: CustomScaffold(
        body: (CustomColorSet colors) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.serviceToMasters),
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
                        ref.read(catalogueProvider.notifier).changeState(6);
                      },
                      title: TrKeys.addServiceToMaster,
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
                    : state.services.isEmpty
                        ? const NoItem(title: TrKeys.noService)
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                AnimationLimiter(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: REdgeInsets.only(
                                        top: 16,
                                        bottom: 56.r,
                                        left: 12,
                                        right: 12),
                                    shrinkWrap: true,
                                    itemCount: state.services.length,
                                    itemBuilder: (context, index) =>
                                        AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: AppConstants.animationDuration,
                                      child: ScaleAnimation(
                                        scale: 0.5,
                                        child: FadeInAnimation(
                                          child: ServiceMasterItem(
                                            service: state.services[index],
                                            spacing: 10,
                                            onTap: () {
                                              // refreshController.resetNoData();
                                              ref
                                                  .read(
                                                      editServiceMasterProvider
                                                          .notifier)
                                                  .setDetails(
                                                    state.services[index],
                                                  )
                                                  .then((v) => ref
                                                      .read(catalogueProvider
                                                          .notifier)
                                                      .changeState(7));
                                            },
                                            onDelete: () {
                                              notifier.deleteService(
                                                context,
                                                state.services[index].id,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (state.hasMore)
                                  HasMoreButton(
                                    hasMore: state.hasMore,
                                    onViewMore: () {
                                      notifier.fetchServices(context: context);
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
