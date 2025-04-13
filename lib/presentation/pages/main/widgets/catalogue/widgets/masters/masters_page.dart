import 'package:admin_desktop/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'widgets/board_view.dart';

class MastersPage extends ConsumerStatefulWidget {
  const MastersPage({super.key});

  @override
  ConsumerState<MastersPage> createState() => _MastersPageState();
}

class _MastersPageState extends ConsumerState<MastersPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newMastersProvider.notifier).fetchMembers(isRefresh: true);
      ref.read(acceptedMastersProvider.notifier).fetchMembers(isRefresh: true);
      ref.read(cancelledMastersProvider.notifier).fetchMembers(isRefresh: true);
      ref.read(rejectedMastersProvider.notifier).fetchMembers(isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listAccepts = ref.watch(acceptedMastersProvider).users;
    final listNew = ref.watch(newMastersProvider).users;
    final listRejected = ref.watch(rejectedMastersProvider).users;
    final listCancel = ref.watch(cancelledMastersProvider).users;

    return CustomScaffold(
        body: (colors) => SafeArea(
              child: Column(
                children: [
                  Container(
                    padding:
                        REdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: const BoxDecoration(color: Style.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(AppHelpers.getTranslation(TrKeys.masters),
                                style: GoogleFonts.inter(
                                  color: Style.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                )),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: BoardViewMode(
                    listNew: listNew,
                    listAccepts: listAccepts,
                    listCanceled: listCancel,
                    listRejected: listRejected,
                  )),
                ],
              ),
            ));
  }
}
