import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ShopLocationsCityPage extends StatefulWidget {
  final WidgetRef ref;

  const ShopLocationsCityPage({super.key, required this.ref});

  @override
  State<ShopLocationsCityPage> createState() => _ShopLocationsCityPageState();
}

class _ShopLocationsCityPageState extends State<ShopLocationsCityPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.ref.read(addressProvider.notifier).fetchCity(
            context: context,
            isRefresh: true,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.ref.watch(addressProvider);
    return KeyboardDisable(
      child: SafeArea(
        bottom: false,
        child: Container(
          margin: REdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r)),
          ),
          padding: REdgeInsets.all(16),
          child: ListView(
            children: [
              Row(
                children: [
                  CustomBackButton(
                    onTap: () => widget.ref
                        .read(profileProvider.notifier)
                        .changeIndex(3),
                  ),
                  const Spacer(),
                  CustomButton(
                    textColor: Style.white,
                    bgColor: Style.primary,
                    title: AppHelpers.getTranslation(TrKeys.wholeCountry),
                    onTap: () {
                      widget.ref.read(shopProvider.notifier)
                        ..addShopLocations(context)
                        ..fetchShopData();
                      widget.ref.read(profileProvider.notifier).changeIndex(3);
                    },
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(16.r),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8.r,
                  crossAxisCount: 5,
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
                  ? const LocationGridListShimmer()
                  : state.hasMore && state.cities.isNotEmpty
                      ? ViewMoreButton(
                          onTap: () {
                            widget.ref
                                .read(addressProvider.notifier)
                                .fetchCity(context: context);
                          },
                        )
                      : const SizedBox(),
              200.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _cityItem(CityData? city) {
    return ButtonEffectAnimation(
      onTap: () {
        widget.ref.read(shopProvider.notifier)
          ..setCityId(city?.id)
          ..addShopLocations(context)
          ..fetchShopData();
        if (context.mounted) {
          widget.ref.read(profileProvider.notifier).changeIndex(3);
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
