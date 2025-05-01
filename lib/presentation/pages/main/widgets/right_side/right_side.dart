import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'page_view_item.dart';
import 'package:admin_desktop/application/right_side/right_side_provider.dart';

class RightSide extends ConsumerStatefulWidget {
  const RightSide({super.key});

  @override
  ConsumerState<RightSide> createState() => _RightSideState();
}

class _RightSideState extends ConsumerState<RightSide> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rightSideProvider.notifier)
        ..fetchBags()
        ..fetchCurrencies(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        )
        ..fetchPayments(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        )
        ..fetchCarts(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rightSideProvider);
    final notifier = ref.read(rightSideProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56.r,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.bags.length,
                  itemBuilder: (context, index) {
                    final bag = state.bags[index];
                    final bool isSelected = state.selectedBagIndex == index;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            notifier.setSelectedBagIndex(index);
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            height: 56.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color:
                                  isSelected ? Style.white : Style.transparent,
                            ),
                            padding: REdgeInsets.only(
                              left: 20,
                              right: index == 0 ? 20 : 4,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Remix.shopping_bag_3_fill,
                                  size: 20.r,
                                  color: isSelected
                                      ? Style.black
                                      : Style.unselectedTab,
                                ),
                                8.horizontalSpace,
                                Text(
                                  '${AppHelpers.getTranslation(TrKeys.bag)} - ${(bag.index ?? 0) + 1}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: isSelected
                                        ? Style.black
                                        : Style.unselectedTab,
                                    letterSpacing: -14 * 0.02,
                                  ),
                                ),
                                if (index != 0)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      16.horizontalSpace,
                                      CircleIconButton(
                                        backgroundColor: Style.transparent,
                                        iconData: Remix.close_line,
                                        iconColor: isSelected
                                            ? Style.black
                                            : Style.unselectedTab,
                                        onTap: () => notifier.removeBag(index),
                                        size: 30,
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                        4.horizontalSpace,
                      ],
                    );
                  },
                ),
              ),
            ),
            9.horizontalSpace,
            InkWell(
              onTap: notifier.addANewBag,
              child: ButtonEffectAnimation(
                child: Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Style.black),
                  child: const Center(
                      child: Icon(
                    Remix.add_line,
                    color: Style.white,
                  )),
                ),
              ),
            ),
          ],
        ),
        6.verticalSpace,
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: state.bags.map((bag) => PageViewItem(bag: bag)).toList(),
          ),
        )
      ],
    );
  }
}
