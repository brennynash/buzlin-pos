import 'package:admin_desktop/domain/models/data/booking_data.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/schedule/details/widgets/forms_page.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/schedule/details/widgets/notes_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/application/bookings/details/booking_details_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import 'widgets/booking_activity_body.dart';
import 'widgets/booking_info_body.dart';
import 'package:flutter/material.dart';
import 'widgets/booking_tab_bar.dart';

class BookingDetailsPage extends ConsumerStatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  ConsumerState<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends ConsumerState<BookingDetailsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingDetailsProvider.notifier).fetchBookingDetails(
          context: context,
          bookingData:
              ref.watch(bookingDetailsProvider).afterUpdatedBookingData ??
                  BookingData());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingDetailsProvider);
    final notifier = ref.read(bookingDetailsProvider.notifier);
    // print("elbekda1 ${state.bookingData?.toJson()}");
    // print("elbekda2 ${state.afterUpdatedBookingData?.toJson()}");
    return Directionality(
      textDirection:
          LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Style.background,
        body: Column(
          children: [
            Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 124.h,
              color: AppHelpers.getStatusColor(state.bookingData?.status)
                  .withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${AppHelpers.getTranslation(state.bookingData?.status ?? '')} — #${state.bookingData?.id ?? 0}",
                          style: Style.interSemi(size: 16),
                        ),
                      ),
                      Text(
                        TimeService.dateFormatEDMY(
                            state.bookingData?.startDate),
                        style: Style.interNormal(size: 14),
                      ),
                    ],
                  ),
                  Divider(height: 12.r),
                  BookingTabBar(
                    tabController: _tabController,
                    status: state.bookingData?.status ?? '',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
                children: const [
                  BookingInfoBody(),
                  NotesPage(),
                  FormsPage(),
                  BookingActivityBody(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopButton(
                popSuccess: () {
                  ref.read(bookingProvider.notifier).changeStateIndex(0);
                },
              ),
              8.horizontalSpace,
              state.bookingData?.status == 'ended' ||
                      state.bookingData?.status == 'canceled' ||
                      state.isLoading ||
                      state.bookingData?.status == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 64.r,
                      child: CustomButton(
                        isLoading: state.isUpdating,
                        bgColor: AppHelpers.getStatusColor(
                            state.bookingData?.status),
                        title: AppHelpers.changeBookingStatusButtonText(
                            state.bookingData?.status),
                        onTap: () {
                          notifier.updateBookingStatus(
                            context,
                            status: AppHelpers.getUpdatableBookingStatus(
                                state.bookingData?.status),
                            success: () {
                              ref.read(bookingProvider.notifier).fetchBookings(
                                    context: context,
                                    isRefresh: true,
                                  );
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
