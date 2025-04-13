import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'add_deliveryman_page.dart';
import 'widgets/deliveryman_item.dart';
import 'widgets/status_dialog.dart';

class DeliveriesPage extends ConsumerStatefulWidget {
  const DeliveriesPage({super.key});

  @override
  ConsumerState<DeliveriesPage> createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends ConsumerState<DeliveriesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(deliverymanProvider.notifier).fetchDeliverymen(
            isRefresh: true,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deliverymanProvider);
    final notifier = ref.read(deliverymanProvider.notifier);
    return Scaffold(
      body: Column(
        children: [
          const HeaderItem(title: TrKeys.deliveries),
          Expanded(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: state.isLoading
                  ? const Loading()
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoSearchTextField(
                            prefixIcon: const Icon(Remix.search_2_line),
                            onChanged: (value) =>
                                notifier.setQuery(query: value),
                          ),
                          ListView.builder(
                            padding: REdgeInsets.symmetric(vertical: 12),
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.users.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => DeliverymanItem(
                              user: state.users[index],
                              onTap: (status) {
                                AppHelpers.showAlertDialog(
                                  context: context,
                                  child: StatusDialog(
                                    id: state
                                        .users[index].invitations?.first.shopId,
                                    status: status,
                                  ),
                                );
                              },
                            ),
                          ),
                          HasMoreButton(
                              hasMore: state.hasMore,
                              onViewMore: notifier.fetchDeliverymen)
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppHelpers.showAlertDialog(
              context: context,
              backgroundColor: Style.bg,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.5,
                width: MediaQuery.sizeOf(context).width / 2,
                child: const AddDeliverymanPage(),
              ));
          //notifier.addTextField();
        },
        backgroundColor: Style.primary,
        child: const Icon(Remix.add_fill),
      ),
    );
  }
}
