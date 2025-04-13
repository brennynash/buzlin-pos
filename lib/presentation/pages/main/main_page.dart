import 'dart:async';
import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/components/custom_clock/custom_clock.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/schedule/schedule_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/customer/customer_notifier.dart';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../components/components.dart';
import '../../theme/theme/theme_wrapper.dart';
import 'widgets/catalogue/catalogue_page.dart';
import 'widgets/comments/comments_page.dart';
import 'widgets/income/income_page.dart';
import 'widgets/language/languages_modal.dart';
import 'widgets/menu/menu_modal.dart';
import 'widgets/notifications/components/notification_count_container.dart';
import 'widgets/notifications/notification_dialog.dart';
import 'widgets/orders_table/orders_table.dart';
import 'widgets/post_page.dart';
import 'widgets/profile/edit_shop/widget/transactions/web_view_page.dart';
import 'widgets/profile/profile_page.dart';
import 'widgets/sale_history/sale_history.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  final user = LocalStorage.getUser();

  late List<IndexedStackChild> list = [
    IndexedStackChild(child: const PostPage(), preload: true),
    IndexedStackChild(child: const OrdersTablesPage()),
    IndexedStackChild(child: const SchedulePage()),
    IndexedStackChild(child: const CommentsPage()),
    IndexedStackChild(child: const SaleHistory()),
    IndexedStackChild(child: const InComePage()),
    IndexedStackChild(child: const CataloguePage()),
    IndexedStackChild(child: const ProfilePage()),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mainProvider.notifier)
        ..changeIndex(0)
        ..fetchMyShop()
        ..fetchUserDetail(onSuccess: () {
          ref.read(mainProvider.notifier)
            ..fetchProducts(
              isRefresh: true,
              checkYourNetwork: () {
                AppHelpers.showSnackBar(
                  context,
                  AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                );
              },
            )
            ..fetchCategories(
              context: context,
              checkYourNetwork: () {
                AppHelpers.showSnackBar(
                  context,
                  AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                );
              },
            );
          ref.read(languagesProvider.notifier).checkLanguage();
        });

      ref.read(rightSideProvider.notifier).fetchUsers(
        checkYourNetwork: () {
          AppHelpers.showSnackBar(
            context,
            AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
          );
        },
      );
      if (mounted) {
        Timer.periodic(
          AppConstants.refreshTime,
          (s) {
            ref.read(notificationProvider.notifier).fetchCount(context);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      languagesProvider,
      (previous, next) {
        if (next.isSelectLanguage &&
            next.isSelectLanguage != previous?.isSelectLanguage) {
          AppHelpers.showAlertDialog(
            context: context,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              width: MediaQuery.sizeOf(context).width / 4,
              child: LanguagesModal(
                afterUpdate: () {
                  context.maybePop();
                },
              ),
            ),
          );
        }
      },
    );

    return SafeArea(
      child: KeyboardDismisser(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(mainProvider);
            final customerNotifier = ref.read(customerProvider.notifier);
            final notifier = ref.read(mainProvider.notifier);
            return CustomScaffold(
              extendBody: true,
              backgroundColor: Style.mainBack,
              body: (c) => Directionality(
                textDirection: LocalStorage.getLangLtr()
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Row(
                  children: [
                    bottomLeftNavigationBar(state),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            color: Style.white,
                            child: IntrinsicHeight(
                              child: ThemeWrapper(
                                builder: (colors, controller) {
                                  return Row(
                                    children: [
                                      30.horizontalSpace,
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Remix.search_2_line,
                                              size: 20,
                                              color: Style.black,
                                            ),
                                            17.horizontalSpace,
                                            Expanded(
                                              flex: 2,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  if (user?.role ==
                                                      TrKeys.seller) {
                                                    ref
                                                                .watch(
                                                                    mainProvider)
                                                                .selectIndex ==
                                                            3
                                                        ? customerNotifier
                                                            .searchUsers(
                                                                context,
                                                                value.trim())
                                                        : notifier
                                                            .setProductsQuery(
                                                                context,
                                                                value.trim());
                                                    if (ref
                                                            .watch(mainProvider)
                                                            .selectIndex ==
                                                        6) {
                                                      if (ref
                                                              .watch(
                                                                  profileProvider)
                                                              .selectIndex ==
                                                          4) {
                                                        ref
                                                            .read(
                                                                addressProvider
                                                                    .notifier)
                                                            .searchCountry(
                                                                context:
                                                                    context,
                                                                search: value
                                                                    .trim());
                                                      } else if (ref
                                                              .watch(
                                                                  profileProvider)
                                                              .selectIndex ==
                                                          5) {
                                                        ref
                                                            .read(
                                                                addressProvider
                                                                    .notifier)
                                                            .searchCity(
                                                                context:
                                                                    context,
                                                                search: value
                                                                    .trim(),
                                                                countyId: ref
                                                                    .watch(
                                                                        addressProvider)
                                                                    .countryId);
                                                      }
                                                    }
                                                  }
                                                },
                                                cursorColor: Style.black,
                                                cursorWidth: 1.r,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: AppHelpers.getTranslation(ref
                                                              .watch(
                                                                  mainProvider)
                                                              .selectIndex ==
                                                          1
                                                      ? TrKeys.searchOrders
                                                      : ref
                                                                  .watch(
                                                                      mainProvider)
                                                                  .selectIndex ==
                                                              2
                                                          ? ref.watch(productProvider).stateIndex ==
                                                                  0
                                                              ? TrKeys
                                                                  .searchProducts
                                                              : ref.watch(productProvider).stateIndex ==
                                                                      3
                                                                  ? TrKeys
                                                                      .searchBrands
                                                                  : TrKeys
                                                                      .searchCategory
                                                          : ref
                                                                      .watch(
                                                                          mainProvider)
                                                                      .selectIndex ==
                                                                  3
                                                              ? AppHelpers.getTranslation(
                                                                  TrKeys
                                                                      .searchComments)
                                                              : ref.watch(mainProvider).selectIndex ==
                                                                      6
                                                                  ? ref.watch(profileProvider).selectIndex ==
                                                                          4
                                                                      ? TrKeys
                                                                          .searchCountry
                                                                      : ref.watch(profileProvider).selectIndex ==
                                                                              5
                                                                          ? TrKeys.searchCity
                                                                          : AppHelpers.getTranslation(TrKeys.searchLocation)
                                                                  : TrKeys.search),
                                                  hintStyle: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Style.searchHint
                                                        .withOpacity(0.3),
                                                    letterSpacing: -14 * 0.02,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const VerticalDivider(),
                                      SizedBox(
                                          width: 120.w,
                                          child: const CustomClock()),
                                      const VerticalDivider(),
                                      IconButton(
                                          onPressed: () async {
                                            // Navigator.of(context)
                                            //     .push(MaterialPageRoute(
                                            //   builder: (context) =>
                                            //       const WebViewPage(
                                            //           url:
                                            //               "${AppConstants.webUrl}/help"),
                                            // ));
                                            context.pushRoute(const HelpRoute());
                                          },
                                          icon: const Icon(
                                            Remix.question_line,
                                            color: Style.black,
                                          )),
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) => const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Dialog(
                                                                  child:
                                                                      NotificationDialog()),
                                                            ],
                                                          ));
                                                },
                                                icon: const Icon(
                                                  Remix.notification_2_line,
                                                  color: Style.black,
                                                )),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: NotificationCountsContainer(
                                                count: ref
                                                    .watch(notificationProvider)
                                                    .countOfNotifications
                                                    ?.notification),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref
                                              .read(languagesProvider.notifier)
                                              .getLanguages(context);
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Dialog(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: SizedBox(
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height /
                                                                2,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width /
                                                                4,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: REdgeInsets
                                                                  .only(
                                                                      left: 15,
                                                                      right: 15,
                                                                      top: 15),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    AppHelpers.getTranslation(
                                                                        TrKeys
                                                                            .language),
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          22,
                                                                      color: Style
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon: const Icon(
                                                                          Remix
                                                                              .close_fill))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  LanguagesModal(
                                                                afterUpdate:
                                                                    () {
                                                                  controller
                                                                      .toggle();
                                                                  controller
                                                                      .toggle();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Remix.global_line,
                                          color: Style.black,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(mainProvider.notifier)
                                              .changeIndex(7);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: ref
                                                            .watch(mainProvider)
                                                            .selectIndex ==
                                                        7
                                                    ? Style.primary
                                                    : Style.textColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: CommonImage(
                                              width: 40,
                                              height: 40,
                                              radius: 20,
                                              url:
                                                  LocalStorage.getUser()?.img ??
                                                      ""),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) => Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Dialog(
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height /
                                                                  1.2,
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width /
                                                                  4,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: REdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15,
                                                                        top:
                                                                            15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      AppHelpers.getTranslation(
                                                                          TrKeys
                                                                              .menu),
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              22,
                                                                          color:
                                                                              Style.black),
                                                                    ),
                                                                    const Spacer(),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        icon: const Icon(
                                                                            Remix.close_fill))
                                                                  ],
                                                                ),
                                                              ),
                                                              const Expanded(
                                                                  child:
                                                                      MenuModal()),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ));
                                        },
                                        icon: const Icon(
                                          Remix.menu_2_line,
                                          color: Style.black,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ProsteIndexedStack(
                                index: state.selectIndex, children: list),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar customAppBar(
      MainNotifier notifier, CustomerNotifier customerNotifier) {
    return AppBar(
      backgroundColor: Style.white,
      automaticallyImplyLeading: false,
      elevation: 0.5,
      title: IntrinsicHeight(
        child: ThemeWrapper(
          builder: (colors, controller) {
            return Row(
              children: [
                16.horizontalSpace,
                GestureDetector(
                    onTap: () {
                      ref
                          .read(mainProvider.notifier)
                          .fetchProducts(isRefresh: true);
                    },
                    child: const AppLogo()),
                const VerticalDivider(),
                30.horizontalSpace,
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Remix.search_2_line,
                        size: 20,
                        color: Style.black,
                      ),
                      17.horizontalSpace,
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          onChanged: (value) {
                            if (user?.role == TrKeys.seller) {
                              ref.watch(mainProvider).selectIndex == 3
                                  ? customerNotifier.searchUsers(
                                      context, value.trim())
                                  : notifier.setProductsQuery(
                                      context, value.trim());
                              if (ref.watch(mainProvider).selectIndex == 6) {
                                if (ref.watch(profileProvider).selectIndex ==
                                    4) {
                                  ref
                                      .read(addressProvider.notifier)
                                      .searchCountry(
                                          context: context,
                                          search: value.trim());
                                } else if (ref
                                        .watch(profileProvider)
                                        .selectIndex ==
                                    5) {
                                  ref.read(addressProvider.notifier).searchCity(
                                      context: context,
                                      search: value.trim(),
                                      countyId:
                                          ref.watch(addressProvider).countryId);
                                }
                              }
                            }
                          },
                          cursorColor: Style.black,
                          cursorWidth: 1.r,
                          decoration: InputDecoration.collapsed(
                            hintText: AppHelpers.getTranslation(ref
                                        .watch(mainProvider)
                                        .selectIndex ==
                                    1
                                ? TrKeys.searchOrders
                                : ref.watch(mainProvider).selectIndex == 2
                                    ? ref.watch(productProvider).stateIndex == 0
                                        ? TrKeys.searchProducts
                                        : ref
                                                    .watch(productProvider)
                                                    .stateIndex ==
                                                3
                                            ? TrKeys.searchBrands
                                            : TrKeys.searchCategory
                                    : ref.watch(mainProvider).selectIndex == 3
                                        ? AppHelpers.getTranslation(
                                            TrKeys.searchComments)
                                        : ref.watch(mainProvider).selectIndex ==
                                                6
                                            ? ref
                                                        .watch(profileProvider)
                                                        .selectIndex ==
                                                    4
                                                ? TrKeys.searchCountry
                                                : ref
                                                            .watch(
                                                                profileProvider)
                                                            .selectIndex ==
                                                        5
                                                    ? TrKeys.searchCity
                                                    : AppHelpers.getTranslation(
                                                        TrKeys.searchLocation)
                                            : TrKeys.search),
                            hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Style.searchHint.withOpacity(0.3),
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                SizedBox(width: 120.w, child: const CustomClock()),
                const VerticalDivider(),
                IconButton(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const WebViewPage(url: "${AppConstants.webUrl}/help"),
                      ));
                    },
                    icon: const Icon(
                      Remix.question_line,
                      color: Style.black,
                    )),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Dialog(child: NotificationDialog()),
                                      ],
                                    ));
                          },
                          icon: const Icon(
                            Remix.notification_2_line,
                            color: Style.black,
                          )),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: NotificationCountsContainer(
                          count: ref
                              .watch(notificationProvider)
                              .countOfNotifications
                              ?.notification),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ref.read(languagesProvider.notifier).getLanguages(context);
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Dialog(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  height: MediaQuery.sizeOf(context).height / 2,
                                  width: MediaQuery.sizeOf(context).width / 4,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: REdgeInsets.only(
                                            left: 15, right: 15, top: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.language),
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                                color: Style.black,
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                   context.maybePop();
                                                },
                                                icon: const Icon(
                                                    Remix.close_fill))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: LanguagesModal(
                                          afterUpdate: () {
                                            controller.toggle();
                                            controller.toggle();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Remix.global_line,
                    color: Style.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.read(mainProvider.notifier).changeIndex(7);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ref.watch(mainProvider).selectIndex == 7
                              ? Style.primary
                              : Style.transparent,
                        ),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: CommonImage(
                        width: 40,
                        height: 40,
                        radius: 20,
                        url: LocalStorage.getUser()?.img ?? ""),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AppHelpers.showCustomDialog(
                      context: context,
                      child: const MenuModal(),
                    );
                  },
                  icon: const Icon(
                    Remix.menu_2_line,
                    color: Style.black,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container bottomLeftNavigationBar(MainState state) {
    return Container(
      height: double.infinity,
      width: state.active ? 150 : 60,
      color: Style.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          24.verticalSpace,
          Row(
            children: [
              8.horizontalSpace,
              if (state.active)
                Text(AppHelpers.getAppName() ?? "",
                    style: Style.interSemi(color: Style.white)),
              const Spacer(),
              CircleIconButton(
                  size: 30,
                  backgroundColor: Style.white,
                  iconData: state.active
                      ? Remix.arrow_left_line
                      : Remix.arrow_right_line,
                  iconColor: Style.black,
                  onTap: () => ref.read(mainProvider.notifier).changeActive()),
              5.horizontalSpace,
            ],
          ),
          28.verticalSpace,
          NavigationItem(
            state: state,
            notifier: ref.read(mainProvider.notifier),
            index: 0,
            icon: Icon(
              state.selectIndex == 0
                  ? Remix.home_smile_fill
                  : Remix.home_smile_line,
              color: state.selectIndex == 0 ? Style.primary : Style.white,
            ),
            title: TrKeys.home,
          ),
          28.verticalSpace,
          NavigationItem(
            state: state,
            notifier: ref.read(mainProvider.notifier),
            index: 1,
            icon: Icon(
              state.selectIndex == 1
                  ? Remix.shopping_bag_fill
                  : Remix.shopping_bag_line,
              color: state.selectIndex == 1 ? Style.primary : Style.white,
            ),
            title: TrKeys.orders,
          ),
          28.verticalSpace,
          NavigationItem(
            state: state,
            notifier: ref.read(mainProvider.notifier),
            index: 2,
            icon: Icon(
              state.selectIndex == 2
                  ? Remix.calendar_todo_fill
                  : Remix.calendar_todo_line,
              color: state.selectIndex == 2 ? Style.primary : Style.white,
            ),
            title: TrKeys.schedule,
          ),
          28.verticalSpace,
          NavigationItem(
            state: state,
            notifier: ref.read(mainProvider.notifier),
            index: 3,
            icon: Icon(
              state.selectIndex == 3 ? Remix.chat_1_fill : Remix.chat_1_line,
              color: state.selectIndex == 3 ? Style.primary : Style.white,
            ),
            title: TrKeys.comments,
          ),
          28.verticalSpace,
          NavigationItem(
              state: state,
              notifier: ref.read(mainProvider.notifier),
              index: 4,
              icon: Icon(
                state.selectIndex == 4
                    ? Remix.money_dollar_circle_fill
                    : Remix.money_dollar_circle_line,
                color: state.selectIndex == 4 ? Style.primary : Style.white,
              ),
              title: TrKeys.saleHistory),
          28.verticalSpace,
          NavigationItem(
            state: state,
            notifier: ref.read(mainProvider.notifier),
            index: 5,
            icon: Icon(
              state.selectIndex == 5
                  ? Remix.pie_chart_fill
                  : Remix.pie_chart_line,
              color: state.selectIndex == 5 ? Style.primary : Style.white,
            ),
            title: TrKeys.income,
          ),
          28.verticalSpace,
          NavigationItem(
            state: state,
            notifier: ref.read(mainProvider.notifier),
            index: 6,
            icon: Icon(
              state.selectIndex == 6 ? Remix.box_1_fill : Remix.box_1_line,
              color: state.selectIndex == 6 ? Style.primary : Style.white,
            ),
            title: TrKeys.sections,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: state.active
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              6.horizontalSpace,
              IconButton(
                  onPressed: () {
                    context.replaceRoute(const LoginRoute());
                    ref.read(newOrdersProvider.notifier).stopTimer();
                    ref.read(acceptedOrdersProvider.notifier).stopTimer();
                    ref.read(readyOrdersProvider.notifier).stopTimer();
                    ref.read(onAWayOrdersProvider.notifier).stopTimer();
                    ref.read(deliveredOrdersProvider.notifier).stopTimer();
                    ref.read(canceledOrdersProvider.notifier).stopTimer();
                    LocalStorage.clearStore();
                  },
                  icon: const Icon(
                    Remix.logout_circle_line,
                    color: Style.white,
                  )),
              5.horizontalSpace,
              if (state.active)
                Text(
                  AppHelpers.getTranslation(TrKeys.logout),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Style.white,
                  ),
                ),
            ],
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.state,
    required this.notifier,
    required this.index,
    required this.icon,
    required this.title,
  });

  final MainState state;
  final MainNotifier notifier;
  final int index;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notifier.changeIndex(index);
      },
      child: Row(
        mainAxisAlignment: state.active
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 6.w,
            height: 40.h,
            decoration: BoxDecoration(
                color: state.selectIndex == index ? Style.primary : Style.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                )),
          ),
          5.horizontalSpace,
          icon,
          5.horizontalSpace,
          if (state.active)
            Text(
              AppHelpers.getTranslation(title),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: state.selectIndex == index ? Style.primary : Style.white,
              ),
            ),
        ],
      ),
    );
  }
}
