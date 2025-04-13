import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ShopLocationsCountryPage extends StatefulWidget {
  final WidgetRef ref;

  const ShopLocationsCountryPage({super.key, required this.ref});

  @override
  State<ShopLocationsCountryPage> createState() =>
      _ShopLocationsCountryPageState();
}

class _ShopLocationsCountryPageState extends State<ShopLocationsCountryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.ref
          .read(addressProvider.notifier)
          .fetchCountry(context: context, isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = widget.ref.read(profileProvider.notifier);
    final notifier = widget.ref.read(addressProvider.notifier);
    final state = widget.ref.watch(addressProvider);
    return KeyboardDisable(
      child: Container(
        margin: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r)),
        ),
        padding: REdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                CustomBackButton(
                  onTap: () => profileNotifier.changeIndex(3),
                ),
              ],
            ),
            8.verticalSpace,
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(16.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.8.r,
                crossAxisCount: 5,
                mainAxisSpacing: 12.r,
                crossAxisSpacing: 8.r,
                mainAxisExtent: 75.r,
              ),
              itemCount: state.countries.length,
              itemBuilder: (context, index) {
                return _countryItem(state.countries[index], () {
                  widget.ref.read(shopProvider.notifier).fetchShopData();
                });
              },
            ),
            state.isCountryLoading
                ? const LocationGridListShimmer()
                : state.hasMoreCountry && state.countries.isNotEmpty
                    ? ViewMoreButton(
                        onTap: () => notifier.fetchCountry(context: context),
                      )
                    : const SizedBox.shrink(),
            200.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _countryItem(CountryData country, VoidCallback onSuccess) {
    return ButtonEffectAnimation(
      onTap: () {
        final shopNotifier = widget.ref.read(shopProvider.notifier);
        final profileNotifier = widget.ref.read(profileProvider.notifier);
        final notifier = widget.ref.read(addressProvider.notifier);
        notifier.setCountryId(country.id ?? 0);
        shopNotifier
          ..setRegionId(country.regionId)
          ..setCountryId(country.id);
        if ((country.citiesCount ?? 0) > 0) {
          profileNotifier.changeIndex(5);
        } else {
          shopNotifier
            ..setRegionId(country.regionId)
            ..setCountryId(country.id)
            ..addShopLocations(context);
          onSuccess();
          profileNotifier.changeIndex(3);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Style.bg,
          border: Border.all(color: Style.icon),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonImage(
                url: country.img ?? "",
                height: 28,
                width: 48,
                radius: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: AutoSizeText(
                  country.translation?.title ?? "",
                  style: Style.interNormal(size: 12),
                  minFontSize: 6,
                  maxFontSize: 14,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
