import 'package:admin_desktop/application/profile/profile_notifier.dart';
import 'package:admin_desktop/application/shop_socials/shop_socials_state.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../application/shop_socials/shop_socials_notifier.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class AddShopSocials extends StatefulWidget {
  final ShopSocialsState state;
  final ShopSocialsNotifier notifier;
  final ProfileNotifier profileNotifier;

  const AddShopSocials(
      {super.key,
      required this.state,
      required this.notifier,
      required this.profileNotifier});

  @override
  State<AddShopSocials> createState() => _AddShopSocialsState();
}

class _AddShopSocialsState extends State<AddShopSocials> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.state.socialControllers.isEmpty
            ? widget.notifier.addTextField(isEdit: true)
            : null;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.background,
      body: widget.state.isSocialLoading
          ? const Center(
              child: Loading(),
            )
          : ListView(
              children: [
                10.verticalSpace,
                Row(
                  children: [
                    CustomBackButton(
                      onTap: () => widget.profileNotifier.changeIndex(6),
                    ),
                    const Spacer(),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 20),
                      child: IconTextButton(
                          radius: BorderRadius.circular(10),
                          iconData: Remix.save_2_line,
                          title: AppHelpers.getTranslation(TrKeys.save),
                          onPressed: () {
                            widget.notifier.addShopSocials(onSuccess: () {
                              if (mounted) {
                                widget.notifier.fetchShopSocials();
                              }
                              widget.profileNotifier.changeIndex(6);
                            });
                          }),
                    ),
                  ],
                ),
                30.verticalSpace,
                Row(
                  children: [
                    20.horizontalSpace,
                    Expanded(
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.state.socialControllers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  20.horizontalSpace,
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Style.white),
                                      child: PopupMenuButton<
                                          MapEntry<String, IconData>>(
                                        itemBuilder: (context) {
                                          return DropDownValues
                                              .socialIcon.entries
                                              .map((social) {
                                            return PopupMenuItem<
                                                MapEntry<String, IconData>>(
                                              value: social,
                                              child: Row(
                                                children: [
                                                  Icon(social.value),
                                                  8.horizontalSpace,
                                                  Text(
                                                    AppHelpers.getTranslation(
                                                        social.key),
                                                    style: Style.interMedium(),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList();
                                        },
                                        onSelected: (selectedSocial) {
                                          widget.notifier.addSocial(
                                              selectedSocial.key, index);
                                        },
                                        child: SelectFromButton(
                                          title: AppHelpers.getTranslation(
                                              widget
                                                  .state
                                                  .socialTypesController[index]
                                                  .text),
                                        ),
                                      ),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Expanded(
                                      child: OutlinedBorderTextField(
                                    hintText: AppHelpers.getTranslation(
                                        TrKeys.addSocials),
                                    textController:
                                        widget.state.socialControllers[index],
                                    label: null,
                                  )),
                                  20.horizontalSpace,
                                  CircleAvatar(
                                    backgroundColor: Style.primary,
                                    child: IconButton(
                                      onPressed: () {
                                        widget.notifier
                                            .removeSocialFromState(index);
                                      },
                                      icon: const Icon(Remix.delete_bin_line),
                                      color: Style.white,
                                    ),
                                  ),
                                  20.horizontalSpace,
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return 8.verticalSpace;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.notifier.addTextField();
        },
        backgroundColor: Style.primary,
        child: const Icon(Remix.add_fill),
      ),
    );
  }
}
