import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../domain/models/models.dart';
import '../../../../../../../components/components.dart';
import '../../../../comments/widgets/no_item.dart';
import '../../service/riverpod/service/service_provider.dart';
import 'service_list_item.dart';

class ServicesModal extends ConsumerStatefulWidget {
  final ValueChanged<ServiceData> onChange;

  const ServicesModal({super.key, required this.onChange});

  @override
  ConsumerState<ServicesModal> createState() => _ServicesModalState();
}

class _ServicesModalState extends ConsumerState<ServicesModal> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (ref.watch(serviceProvider).services.isEmpty) {
          ref
              .read(serviceProvider.notifier)
              .fetchServices(isRefresh: true, context: context);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceProvider);
    final notifier = ref.read(serviceProvider.notifier);
    return Column(
      children: [
        Expanded(
          child: state.isLoading
              ? const Loading()
              : SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () => notifier.fetchServices(
                    context: context,
                    isRefresh: true,
                    controller: _refreshController,
                  ),
                  onLoading: () => notifier.fetchServices(
                    context: context,
                    controller: _refreshController,
                  ),
                  child: state.services.isEmpty
                      ? const NoItem(title: TrKeys.noService)
                      : AnimationLimiter(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: REdgeInsets.only(
                                top: 16, bottom: 56.r, left: 12, right: 12),
                            shrinkWrap: true,
                            itemCount: state.services.length,
                            itemBuilder: (context, index) =>
                                AnimationConfiguration.staggeredList(
                              position: index,
                              duration: AppConstants.animationDuration,
                              child: ScaleAnimation(
                                scale: 0.5,
                                child: FadeInAnimation(
                                  child: ServiceListItem(
                                    service: state.services[index],
                                    spacing: 10,
                                    onTap: () {
                                      widget.onChange
                                          .call(state.services[index]);
                                       context.maybePop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
        ),
        24.verticalSpace,
      ],
    );
  }
}
