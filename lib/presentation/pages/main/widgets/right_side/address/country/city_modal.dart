import 'package:admin_desktop/domain/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class CityModal extends ConsumerStatefulWidget {
  final int countryId;

  const CityModal({super.key, required this.countryId});

  @override
  ConsumerState<CityModal> createState() => _CityModalState();
}

class _CityModalState extends ConsumerState<CityModal> {
  final RefreshController controller = RefreshController();
  final Delayed delayed = Delayed(milliseconds: 700);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addressProvider.notifier).fetchCity(
            context: context,
            isRefresh: true,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: SafeArea(
        bottom: false,
        child: Consumer(builder: (context, ref, child) {
          final state = ref.watch(addressProvider);
          final notifier = ref.read(addressProvider.notifier);
          return ListView(
            children: [
              Row(
                children: [
                  18.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.selectCity),
                    style: Style.interSemi(size: 18),
                  ),
                  const Spacer(),
                  IconButton(
                      splashRadius: 5.r,
                      onPressed: () {
                        context.maybePop();
                      },
                      icon: const Icon(Remix.close_line))
                ],
              ),
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: OutlinedBorderTextField(
                  onChanged: (s) {
                    if (s.trim().isNotEmpty) {
                      delayed.run(() {
                        notifier.searchCity(
                          context: context,
                          search: s,
                          countyId: widget.countryId,
                        );
                      });
                    }
                  },
                  label: null,
                  hintText: AppHelpers.getTranslation(TrKeys.search),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16.r),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8.r,
                  crossAxisCount: 4,
                  mainAxisSpacing: 12.r,
                  crossAxisSpacing: 8.r,
                  mainAxisExtent: 56.r,
                ),
                itemCount: state.cities.length,
                itemBuilder: (context, index) {
                  return _cityItem(state.cities[index]);
                },
              ),
              state.isCityLoading
                  ? const LocationGridListShimmer(
                      count: 4,
                    )
                  : state.hasMore && state.cities.isNotEmpty
                      ? ViewMoreButton(
                          onTap: () {
                            notifier.fetchCity(context: context);
                          },
                        )
                      : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }

  Widget _cityItem(CityData? city) {
    return ButtonEffectAnimation(
      onTap: () {
        final state = ref.read(rightSideProvider);
        final notifier = ref.read(rightSideProvider.notifier);
        ref.read(rightSideProvider.notifier).setCity(city);
        if (state.orderType == TrKeys.delivery) {
          notifier.getDeliveryPrices();
        } else {
          ref.read(pickupPointsProvider.notifier).fetchPoints(
                countyId: city?.countryId,
                context: context,
                regionId: city?.id,
                isRefresh: true,
                rightSideNotifier: notifier,
              );
        }
        // ref.read(rightSideProvider.notifier).setDeliveryPoint(ref.watch(pickupPointsProvider).deliveryPoints.first);
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Style.greyColor,
          border: Border.all(color: Style.icon),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: AutoSizeText(
              city?.translation?.title ?? "",
              style: Style.interNormal(color: Style.black, size: 12),
              minFontSize: 6,
              maxFontSize: 14,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
