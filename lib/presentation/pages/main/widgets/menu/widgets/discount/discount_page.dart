import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../comments/widgets/no_item.dart';
import 'add_discount/add_discount_page.dart';
import 'edit_discount/edit_discount_page.dart';
import 'widgets/discount_item.dart';

class DiscountPage extends ConsumerStatefulWidget {
  const DiscountPage({super.key});

  @override
  ConsumerState<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends ConsumerState<DiscountPage> {
  late RefreshController discountController;

  @override
  void initState() {
    discountController = RefreshController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(discountProvider.notifier)
          .fetchDiscounts(context: context, isRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bg,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const HeaderItem(title: TrKeys.discount),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final discountState = ref.watch(discountProvider);
                final discountEvent = ref.read(discountProvider.notifier);
                return discountState.isLoading
                    ? const Center(child: Loading())
                    : discountState.discounts.isEmpty
                        ? const NoItem(title: TrKeys.noDiscount)
                        : AnimationLimiter(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: REdgeInsets.only(
                                        top: 16,
                                        bottom: 56.r,
                                        left: 12,
                                        right: 12),
                                    shrinkWrap: true,
                                    itemCount: discountState.discounts.length,
                                    itemBuilder: (context, index) =>
                                        AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: AppConstants.animationDuration,
                                      child: ScaleAnimation(
                                        scale: 0.5,
                                        child: FadeInAnimation(
                                          child: DiscountItem(
                                            discountData:
                                                discountState.discounts[index],
                                            spacing: 10,
                                            onTap: () {
                                              ref
                                                  .read(editDiscountProvider
                                                      .notifier)
                                                  .setDiscountDetails(
                                                      discountState
                                                          .discounts[index],
                                                      (fullBrand) {});
                                              AppHelpers.showAlertDialog(
                                                  context: context,
                                                  child: SizedBox(
                                                    height: 0.67.sh,
                                                    width: 0.5.sw,
                                                    child: EditDiscountPage(
                                                        discountState
                                                                .discounts[
                                                                    index]
                                                                .id ??
                                                            0),
                                                  ));
                                            },
                                            onDelete: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        titlePadding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        actionsPadding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        title: Text(
                                                          AppHelpers.getTranslation(
                                                              TrKeys
                                                                  .deleteProduct),
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 18,
                                                            color: Style.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        actions: [
                                                          SizedBox(
                                                            width: 112.r,
                                                            child: ConfirmButton(
                                                                paddingSize: 0,
                                                                title: AppHelpers
                                                                    .getTranslation(
                                                                        TrKeys
                                                                            .no),
                                                                onTap: () =>
                                                                    Navigator.pop(
                                                                        context)),
                                                          ),
                                                          SizedBox(
                                                            width: 112.r,
                                                            child:
                                                                ConfirmButton(
                                                                    paddingSize:
                                                                        0,
                                                                    title: AppHelpers
                                                                        .getTranslation(
                                                                            TrKeys.yes),
                                                                    onTap: () {
                                                                      ref.read(discountProvider.notifier).deleteDiscount(
                                                                          context,
                                                                          discountState.discounts[index].id ??
                                                                              0);

                                                                      Navigator.pop(
                                                                          context);
                                                                    }),
                                                          ),
                                                        ],
                                                      ));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (discountState.hasMore)
                                    HasMoreButton(
                                        hasMore: discountState.hasMore,
                                        onViewMore: () => discountEvent
                                            .fetchDiscounts(context: context))
                                ],
                              ),
                            ),
                          );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppHelpers.showAlertDialog(
              context: context,
              child: SizedBox(
                height: 0.67.sh,
                width: 0.5.sw,
                child: const AddDiscountPage(),
              ));
          //notifier.addTextField();
        },
        backgroundColor: Style.primary,
        child: const Icon(Remix.add_fill),
      ),
    );
  }
}
