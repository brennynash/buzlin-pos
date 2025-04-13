import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/menu/widgets/gift_card/add/add_gift_card_page.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/menu/widgets/gift_card/edit/edit_gift_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import '../../../../../../../application/gift_cards/gift_card_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../components/delete_modal.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../comments/widgets/no_item.dart';
import 'widgets/gift_card_item.dart';

class GiftCardsPage extends ConsumerStatefulWidget {
  const GiftCardsPage({super.key});

  @override
  ConsumerState<GiftCardsPage> createState() => _GiftCardsPageState();
}

class _GiftCardsPageState extends ConsumerState<GiftCardsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) =>
          ref.read(giftCardProvider.notifier).fetchGiftCards(isRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(giftCardProvider);
            final notifier = ref.read(giftCardProvider.notifier);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeaderItem(title: TrKeys.giftCarts),
                Expanded(
                  child: state.isLoading
                      ? const Loading()
                      : state.list.isEmpty
                          ? const NoItem(
                              title: TrKeys.noGiftCards,
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.list.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: REdgeInsets.all(12),
                                    itemBuilder: (context, index) {
                                      return GiftCardItem(
                                        giftCard: state.list[index],
                                        onEdit: () {
                                          AppHelpers.showAlertDialog(
                                              backgroundColor: Style.bg,
                                              context: context,
                                              child: SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height /
                                                        1.5,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        2,
                                                child: EditGiftCardPage(
                                                    giftCardData:
                                                        state.list[index]),
                                              ));
                                          // context.pushRoute(
                                          //   EditGiftCardRoute(
                                          //     giftCardData: state.list[index],
                                          //   ),
                                          // );
                                        },
                                        onDelete: () {
                                          AppHelpers.showCustomModalBottomSheet(
                                            context: context,
                                            modal: DeleteModal(
                                              onDelete: () {
                                                notifier.deleteGiftCard(
                                                  context,
                                                  state.list[index].id,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  HasMoreButton(
                                      hasMore: state.hasMore,
                                      onViewMore: () => notifier.fetchGiftCards(
                                          context: context))
                                ],
                              ),
                            ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppHelpers.showAlertDialog(
                context: context,
                child: SizedBox(
                  height: 0.67.sh,
                  width: 0.5.sw,
                  child: const AddGiftCardPage(),
                ));
            //notifier.addTextField();
          },
          backgroundColor: Style.primary,
          child: const Icon(Remix.add_fill),
        ),
      ),
    );
  }
}
