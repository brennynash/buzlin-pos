import 'package:admin_desktop/application/bookings/user/order_user_provider.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/application/bookings/create/create_booking_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'widgets/service_item.dart';

class CreateEventPage extends ConsumerStatefulWidget {
  const CreateEventPage({super.key});

  @override
  ConsumerState<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  num totalPrice = 0;
  num duration = 0;
  int service = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(createBookingProvider).services.isEmpty) {
        ref.read(createBookingProvider.notifier).fetchServices(
              context: context,
              isRefresh: true,
            );
      }
      ref.read(createBookingProvider.notifier).clearSelect();
      ref.read(orderUserProvider.notifier).clearSelectedUserInfo();
      ref.read(createBookingProvider.notifier).fetchUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createBookingProvider);
    final notifier = ref.read(createBookingProvider.notifier);
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Style.white,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: REdgeInsets.all(16),
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Style.unselectedBottomBarBack,
                              width: 1.r,
                            ),
                          ),
                          alignment: Alignment.center,
                          height: 56.r,
                          width: 280.r,
                          padding: EdgeInsets.only(left: 16.r),
                          child: CustomDropdown(
                            isOrdering: false,
                            hintText:
                                AppHelpers.getTranslation(TrKeys.selectUser),
                            searchHintText:
                                AppHelpers.getTranslation(TrKeys.searchUser),
                            dropDownType: DropDownType.users,
                            onChanged: (value) {
                              notifier.setUsersQuery(context, value);
                            },
                          ),
                        ),
                        Visibility(
                          visible: state.selectUserError != null,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.r, left: 4.r),
                            child: Text(
                              AppHelpers.getTranslation(
                                  state.selectUserError ?? ""),
                              style: GoogleFonts.inter(
                                  color: Style.red, fontSize: 14.sp),
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 100.r),
                            itemCount: state.services.length,
                            itemBuilder: (context, index) {
                              return ServiceItem(
                                booked: state.selectServices.any((element) =>
                                    element.id == state.services[index].id),
                                service: state.services[index],
                                onTap: () {
                                  notifier.setSelectedService(
                                      service: state.services[index],
                                      onChange: (services) {
                                        totalPrice = 0;
                                        duration = 0;
                                        service = 0;
                                        if (services.isEmpty) {
                                          return;
                                        }
                                        for (var element in services) {
                                          totalPrice +=
                                              (element.totalPrice ?? 0);
                                          duration += (element.interval ?? 0);
                                        }
                                        service = services.length;
                                      });
                                },
                              );
                            }),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (state.isLoading) const Loading()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              PopButton(
                popSuccess: () {
                  ref.read(bookingProvider.notifier).changeStateIndex(0);
                },
              ),
              12.horizontalSpace,
              Expanded(
                child: ButtonEffectAnimation(
                  onTap: () {
                    if (state.selectServices.isEmpty) return;
                    final user = ref.watch(createBookingProvider).selectedUser;
                    if (user == null) {
                      AppHelpers.errorSnackBar(context,
                          text: AppHelpers.getTranslation(
                              TrKeys.pleaseSelectAUser));
                      return;
                    }
                    notifier.setUser(user);
                    ref.read(bookingProvider.notifier).changeStateIndex(2);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16.r),
                    height: 64.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Style.primary,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppHelpers.getTranslation(TrKeys.from)} ${AppHelpers.numberFormat(number: totalPrice)}",
                          style:
                              Style.interNormal(color: Style.white, size: 16),
                        ),
                        Text(
                          "$service ${AppHelpers.getTranslation(TrKeys.services)} - $duration ${AppHelpers.getTranslation(TrKeys.minute)}",
                          style:
                              Style.interRegular(color: Style.white, size: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
