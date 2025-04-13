import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ShopLocationsPage extends StatelessWidget {
  const ShopLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(shopProvider);
        return Container(
          margin: const EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: IconTextButton(
                        radius: BorderRadius.circular(10),
                        iconData: Icons.add,
                        title: AppHelpers.getTranslation(TrKeys.addLocation),
                        onPressed: () {
                          ref.read(profileProvider.notifier).changeIndex(4);
                        }),
                  )
                ],
              ),
              Expanded(
                child: state.isShopLocationsLoading || state.isEditShopData
                    ? const Center(
                        child: Loading(),
                      )
                    : state.editShopData?.locations?.isEmpty ?? true
                        ? const SizedBox.shrink()
                        : ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount:
                                state.editShopData?.locations?.length ?? 0,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                child: ScaleAnimation(
                                  scale: 0.5,
                                  child: FadeInAnimation(
                                    child: CountryItem(
                                        countryData: state.editShopData
                                                ?.locations![index].country ??
                                            CountryData(),
                                        cityData: state.editShopData
                                            ?.locations?[index].city,
                                        id: state.editShopData
                                                ?.locations![index].id ??
                                            0,
                                        onTap: () => ref
                                            .read(shopProvider.notifier)
                                            .deleteShopLocation(
                                                context,
                                                state
                                                        .editShopData
                                                        ?.locations![index]
                                                        .id ??
                                                    0)),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return 8.verticalSpace;
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CountryItem extends StatelessWidget {
  final CountryData countryData;
  final CityData? cityData;
  final int id;
  final VoidCallback onTap;
  final double spacing;

  const CountryItem({
    super.key,
    required this.countryData,
    required this.onTap,
    this.spacing = 1,
    required this.id,
    this.cityData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.background,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: spacing),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                    color: countryData.active == null
                        ? Style.red
                        : countryData.active!
                            ? Style.green
                            : Style.red,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
              ),
              12.horizontalSpace,
              CommonImage(
                isResponsive: false,
                width: 48,
                height: 48,
                url: countryData.img,
                errorRadius: 0,
                fit: BoxFit.cover,
              ),
              8.horizontalSpace,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: cityData == null
                          ? Text(
                              countryData.translation?.title ?? '',
                              style: Style.interRegular(
                                size: 15,
                                color: Style.black,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : RichText(
                              text: TextSpan(
                                  text: '${countryData.translation?.title}',
                                  style: Style.interRegular(
                                    size: 14,
                                    color: Style.black,
                                    letterSpacing: -0.3,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ', ${cityData?.translation?.title}',
                                      style: Style.interRegular(
                                        size: 14,
                                        color: Style.black,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ]),
                            ),
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        CircleButton(
                          backgroundColor: Style.white,
                          onTap: onTap,
                          icon: Remix.delete_bin_line,
                        ),
                        8.horizontalSpace,
                      ],
                    ),
                  ],
                ),
              ),
              12.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
