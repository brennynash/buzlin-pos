import 'package:admin_desktop/presentation/components/custom_expansion_tile.dart';
import 'widgets/forms/form_option_page.dart';
import 'widgets/gift_card/gift_cards_page.dart';
import 'widgets/gift_card/user_gift_cards_page.dart';
import 'widgets/membership/membership_page.dart';
import 'widgets/membership/user_membership_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../profile/edit_profile/stories/stories/stories_page.dart';
import 'widgets/ads/ads_package_page.dart';
import 'widgets/ads/ads_page.dart';
import 'widgets/discount/discount_page.dart';
import 'widgets/looks/looks_page.dart';
import 'widgets/sections_item.dart';
import 'widgets/subscriptions/subscriptions_page.dart';

class MenuModal extends ConsumerWidget {
  final VoidCallback? afterUpdate;

  const MenuModal({super.key, this.afterUpdate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      children: [
        SectionsItem(
          onTap: () {
            AppHelpers.showAlertDialog(
                context: context,
                child: SizedBox(
                  height: 0.67.sh,
                  width: 0.5.sw,
                  child: const DiscountPage(),
                ),
                backgroundColor: Style.bg);
          },
          title: AppHelpers.getTranslation(TrKeys.discount),
          icon: Remix.percent_line,
        ),
        SectionsItem(
          onTap: () {
            AppHelpers.showAlertDialog(
              context: context,
              backgroundColor: Style.bg,
              child: SizedBox(
                  height: 0.67.sh, width: 0.5.sw, child: const LooksPage()),
            );
          },
          title: AppHelpers.getTranslation(TrKeys.looks),
          icon: Remix.typhoon_line,
        ),
        CustomExpansionTile(
            title: SectionsItem(
              isDivider: false,
              icon: Remix.advertisement_line,
              onTap: () {
                AppHelpers.showAlertDialog(
                    context: context,
                    child: SizedBox(
                        height: 0.67.sh,
                        width: 0.5.sw,
                        child: const AdsPage()));
              },
              title: AppHelpers.getTranslation(TrKeys.ads),
            ),
            children: [
              SectionsItem(
                icon: Remix.advertisement_line,
                onTap: () {
                  AppHelpers.showAlertDialog(
                      context: context,
                      child: SizedBox(
                          height: 0.67.sh,
                          width: 0.5.sw,
                          child: const AdsPackagePage()));
                },
                title: AppHelpers.getTranslation(TrKeys.adPackages),
              ),
            ]),
        SectionsItem(
          onTap: () {
            AppHelpers.showAlertDialog(
                context: context,
                child: SizedBox(
                    height: 0.67.sh,
                    width: 0.5.sw,
                    child: const StoriesPage()));
          },
          title: AppHelpers.getTranslation(TrKeys.stories),
          icon: Remix.time_line,
        ),
        CustomExpansionTile(
            title: SectionsItem(
              isDivider: false,
              onTap: () {
                AppHelpers.showAlertDialog(
                    context: context,
                    backgroundColor: Style.bg,
                    child: SizedBox(
                        height: 0.67.sh,
                        width: 0.5.sw,
                        child: const MembershipPage()));
              },
              title: AppHelpers.getTranslation(TrKeys.membership),
              icon: Icons.verified_outlined,
            ),
            children: [
              SectionsItem(
                onTap: () {
                  AppHelpers.showAlertDialog(
                      context: context,
                      backgroundColor: Style.bg,
                      child: SizedBox(
                          height: 0.67.sh,
                          width: 0.5.sw,
                          child: const UserMembershipPage()));
                },
                title: AppHelpers.getTranslation(TrKeys.userMembership),
                icon: Icons.verified_outlined,
              ),
            ]),
        CustomExpansionTile(
          title: SectionsItem(
            isDivider: false,
            onTap: () {
              AppHelpers.showAlertDialog(
                context: context,
                backgroundColor: Style.bg,
                child: SizedBox(
                    height: 0.67.sh,
                    width: 0.5.sw,
                    child: const GiftCardsPage()),
              );
            },
            title: AppHelpers.getTranslation(TrKeys.giftCarts),
            icon: Remix.gift_line,
          ),
          children: [
            SectionsItem(
              onTap: () {
                AppHelpers.showAlertDialog(
                    context: context,
                    backgroundColor: Style.bg,
                    child: SizedBox(
                        height: 0.67.sh,
                        width: 0.5.sw,
                        child: const UserGiftCardPage()));
              },
              title: AppHelpers.getTranslation(TrKeys.userGiftCards),
              icon: Remix.gift_line,
            ),
          ],
        ),
        SectionsItem(
            onTap: () {
              AppHelpers.showAlertDialog(
                  context: context,
                  backgroundColor: Style.bg,
                  child: SizedBox(
                      height: 0.67.sh,
                      width: 0.5.sw,
                      child: const FormOptionPage()));
            },
            title: AppHelpers.getTranslation(TrKeys.forms),
            icon: Remix.file_text_line),
        if (AppHelpers.getSubscription())
          SectionsItem(
            isDivider: false,
            icon: Icons.verified_outlined,
            onTap: () {
              AppHelpers.showAlertDialog(
                  backgroundColor: Style.bg,
                  context: context,
                  child: SizedBox(
                      height: 0.67.sh,
                      width: 0.5.sw,
                      child: const SubscriptionsPage()));
            },
            title: AppHelpers.getTranslation(TrKeys.subscription),
          ),
        // if (LocalStorage.getShop()?.deliveryType == 2)
        //   SectionsItem(
        //     isDivider: false,
        //     icon: Remix.truck_line,
        //     onTap: () {
        //       AppHelpers.showAlertDialog(
        //           backgroundColor: Style.bg,
        //           context: context,
        //           child: SizedBox(
        //               height: 0.67.sh,
        //               width: 0.5.sw,
        //               child: const AddDeliverymanPage()));
        //     },
        //     title: AppHelpers.getTranslation(TrKeys.deliveries),
        //   ),
      ],
    );
  }
}
