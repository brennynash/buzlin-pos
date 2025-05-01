import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../application/bookings/details/booking_details_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../components/buttons/custom_action_button.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({super.key});

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  late TextEditingController note;

  @override
  void initState() {
    note = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingDetailsProvider);
    final notifier = ref.read(bookingDetailsProvider.notifier);
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: state.bookingData?.notes?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin: REdgeInsets.only(bottom: 6),
                  padding: REdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Style.borderColor,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius / 1.2)),
                  child: Text(
                    state.bookingData?.notes?[index] ?? '',
                    style: Style.interNormal(size: 15),
                  ),
                );
              }),
          16.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: OutlinedBorderTextField(
                  maxLine: 1,
                  textController: note,
                  validator: AppValidators.emptyCheck,
                  label: null,
                ),
              ),
              8.horizontalSpace,
              CustomActionButton(
                icon: Icons.check,
                isLoading: state.isUpdateNote,
                onPressed: () {
                  if (note.text.isNotEmpty) {
                    notifier.updateBookingNotes(context, note: note.text);
                    note.clear();
                  }
                },
                isShadow: false,
                backgroundColor:
                    AppHelpers.getStatusColor(state.bookingData?.status),
              )
            ],
          ),
          (MediaQuery.sizeOf(context).height / 3).verticalSpace,
        ],
      ),
    );
  }
}
