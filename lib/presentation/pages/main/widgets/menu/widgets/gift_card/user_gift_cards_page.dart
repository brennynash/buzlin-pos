import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../../../../../application/gift_cards/user_gift_card/user_gift_card_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../comments/widgets/no_item.dart';
import 'widgets/user_gift_card_item.dart';

class UserGiftCardPage extends ConsumerStatefulWidget {
  const UserGiftCardPage({super.key});

  @override
  ConsumerState<UserGiftCardPage> createState() => _UserGiftCardPageState();
}

class _UserGiftCardPageState extends ConsumerState<UserGiftCardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(userGiftCardProvider.notifier)
          .fetchUserGiftCards(isRefresh: true),
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
            final state = ref.watch(userGiftCardProvider);
            final notifier = ref.read(userGiftCardProvider.notifier);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeaderItem(title: TrKeys.userGiftCards),
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
                                    padding: REdgeInsets.all(12),
                                    itemBuilder: (context, index) {
                                      return UserGiftCardItem(
                                        userGiftCard: state.list[index],
                                      );
                                    },
                                  ),
                                  HasMoreButton(
                                      hasMore: state.hasMore,
                                      onViewMore: () => notifier
                                          .fetchUserGiftCards(context: context))
                                ],
                              ),
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
