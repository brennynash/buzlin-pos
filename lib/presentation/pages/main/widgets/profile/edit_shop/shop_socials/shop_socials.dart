import 'package:admin_desktop/application/shop_socials/shop_socials_notifier.dart';
import 'package:admin_desktop/application/shop_socials/shop_socials_state.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:admin_desktop/domain/models/models.dart';
import '../../../../../../../application/profile/profile_notifier.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ShopSocialsPage extends StatefulWidget {
  final ShopSocialsState state;
  final ShopSocialsNotifier notifier;
  final ProfileNotifier profileNotifier;

  const ShopSocialsPage(
      {super.key,
      required this.state,
      required this.notifier,
      required this.profileNotifier});

  @override
  State<ShopSocialsPage> createState() => _ShopSocialsPageState();
}

class _ShopSocialsPageState extends State<ShopSocialsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.notifier.fetchShopSocials();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Container(
          decoration: const BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: widget.state.isSocialLoading
              ? const Center(child: Loading())
              : Column(
                  // shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20),
                          child: IconTextButton(
                              radius: BorderRadius.circular(10),
                              iconData: Remix.edit_box_line,
                              title: AppHelpers.getTranslation(
                                  TrKeys.editShopSocials),
                              onPressed: () {
                                widget.profileNotifier.changeIndex(7);
                              }),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Expanded(
                      child: widget.state.socialData?.isEmpty ?? true
                          ? const SizedBox.shrink()
                          : ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20),
                              itemCount: widget.state.socialData?.length ?? 0,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: ScaleAnimation(
                                    scale: 0.5,
                                    child: FadeInAnimation(
                                      child: _socialItem(
                                        socialData:
                                            widget.state.socialData?[index] ??
                                                SocialData(),
                                        onDelete: () {
                                          widget.notifier.deleteShopSocials(
                                              context,
                                              widget.state.socialData?[index]
                                                      .id ??
                                                  0);
                                        },
                                      ),
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
                    56.verticalSpace,
                  ],
                ),
        ),
      ),
    );
  }

  Widget _socialItem(
      {required SocialData socialData, required VoidCallback onDelete}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Style.background,
        border: Border.all(color: Style.icon),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: AppHelpers.getTranslation(
                    socialData.type ?? TrKeys.instagram),
                style: Style.interBold(),
                children: [
                  TextSpan(
                      text: ' : ${socialData.content}',
                      style: Style.interBold())
                ]),
          ),
          const Spacer(),
          CircleButton(
            backgroundColor: Style.white,
            onTap: onDelete,
            icon: Remix.delete_bin_line,
          ),
        ],
      ),
    );
  }
}
