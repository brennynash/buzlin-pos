import 'package:admin_desktop/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../right_side/address/select_address_page.dart';
import 'edit_profile/edit_profile.dart';
import 'edit_shop/shop_gallery/shop_gallery.dart';
import 'widgets/profile_top_bar.dart';
import 'edit_shop/edit_shop.dart';
import 'edit_shop/edit_shop_locations_page.dart';
import 'edit_shop/shop_locations_city_page.dart';
import 'edit_shop/shop_locations_country_page.dart';
import 'edit_shop/shop_socials/add_shop_socials.dart';
import 'edit_shop/shop_socials/shop_socials.dart';
import 'edit_shop/widget/transactions/transaction_list_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(profileProvider.notifier);
    final state = ref.watch(profileProvider);
    final shopState = ref.watch(shopProvider);
    return CustomScaffold(
        body: (colors) => state.selectIndex == 7
            ? AddShopSocials(
                state: ref.watch(shopSocialsProvider),
                notifier: ref.read(shopSocialsProvider.notifier),
                profileNotifier: notifier,
              )
            : state.selectIndex == 8
                ? TransactionListPage(ref: ref)
                : state.selectIndex == 4
                    ? ShopLocationsCountryPage(ref: ref)
                    : state.selectIndex == 5
                        ? ShopLocationsCityPage(ref: ref)
                        : state.selectIndex == 2
                            ? SelectAddressPage(
                                isShopLocation: true,
                                location: LocationData(
                                    latitude: shopState
                                            .editShopData?.latLong?.latitude ??
                                        AppConstants.demoLatitude,
                                    longitude: shopState
                                            .editShopData?.latLong?.longitude ??
                                        AppConstants.demoLongitude),
                                onSelect: (address) {
                                  ref
                                      .read(rightSideProvider.notifier)
                                      .setSelectedAddress(address: address);
                                  ref
                                      .read(rightSideProvider.notifier)
                                      .fetchCarts(
                                          checkYourNetwork: () {
                                            AppHelpers.showSnackBar(
                                              context,
                                              AppHelpers.getTranslation(TrKeys
                                                  .checkYourNetworkConnection),
                                            );
                                          },
                                          isNotLoading: true);
                                },
                              )
                            : Column(
                                children: [
                                  20.verticalSpace,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ProfileTopBar(
                                          title: TrKeys.profile,
                                          isActive: state.selectIndex == 0,
                                          onTap: () => notifier.changeIndex(0),
                                        ),
                                        8.horizontalSpace,
                                        ProfileTopBar(
                                          title: TrKeys.editShop,
                                          isActive: state.selectIndex == 1,
                                          onTap: () => notifier.changeIndex(1),
                                        ),
                                        8.horizontalSpace,
                                        ProfileTopBar(
                                          title: TrKeys.shopLocation,
                                          isActive: state.selectIndex == 3,
                                          onTap: () => notifier.changeIndex(3),
                                        ),
                                        8.horizontalSpace,
                                        ProfileTopBar(
                                          title: TrKeys.socials,
                                          isActive: state.selectIndex == 6,
                                          onTap: () => notifier.changeIndex(6),
                                        ),
                                        8.horizontalSpace,
                                        ProfileTopBar(
                                          title: TrKeys.gallery,
                                          isActive: state.selectIndex == 9,
                                          onTap: () => notifier.changeIndex(9),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: state.selectIndex == 0
                                          ? EditProfileWidget(
                                              state: ref
                                                  .watch(editProfileProvider),
                                              notifier: ref.read(
                                                  editProfileProvider.notifier),
                                              profileNotifier: notifier)
                                          : state.selectIndex == 1
                                              ? EditShop(
                                                  notifier: ref.read(
                                                      shopProvider.notifier),
                                                  state:
                                                      ref.watch(shopProvider),
                                                  profileNotofier: notifier,
                                                )
                                              : state.selectIndex == 3
                                                  ? const ShopLocationsPage()
                                                  : state.selectIndex == 6
                                                      ? ShopSocialsPage(
                                                          state: ref.watch(
                                                              shopSocialsProvider),
                                                          notifier: ref.read(
                                                              shopSocialsProvider
                                                                  .notifier),
                                                          profileNotifier:
                                                              notifier,
                                                        )
                                                      : ShopGallery(
                                                          state: ref.watch(
                                                              shopGalleriesProvider),
                                                          notifier: ref.read(
                                                              shopGalleriesProvider
                                                                  .notifier),
                                                        )),
                                ],
                              ));
  }
}
