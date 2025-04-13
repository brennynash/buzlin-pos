import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/application/bookings/create/create_booking_provider.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'booking_payment_modal.dart';
import 'widgets/price_item.dart';

class AddNotePage extends ConsumerStatefulWidget {
  const AddNotePage({super.key});

  @override
  ConsumerState<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends ConsumerState<AddNotePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(createBookingProvider.notifier).calculateBooking(
          context: context,
          date: ref.watch(createBookingProvider).selectDateTime);
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: REdgeInsets.all(16),
                child: Text(
                  AppHelpers.getTranslation(TrKeys.optionalNotes),
                  style: Style.interMedium(size: 18),
                ),
              ),
              Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.r, horizontal: 16.r),
                        shrinkWrap: true,
                        itemCount: state.selectMasters.length,
                        itemBuilder: (context, index) {
                          final selectMaster =
                              state.selectMasters.values.elementAt(index);
                          final errors = state.calculate?.items
                                  ?.firstWhere(
                                      (element) =>
                                          element.serviceMaster?.service?.id ==
                                          selectMaster
                                              .serviceMaster?.service?.id,
                                      orElse: () => CalculateItem())
                                  .errors ??
                              [];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              24.verticalSpace,
                              Row(
                                children: [
                                  Text(
                                    selectMaster.serviceMaster?.service
                                            ?.translation?.title ??
                                        "",
                                    style: Style.interNormal(),
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if ((selectMaster
                                                  .serviceMaster?.totalPrice ??
                                              0) !=
                                          0)
                                        Text(
                                          AppHelpers.numberFormat(
                                            number: selectMaster
                                                .serviceMaster?.price,
                                          ),
                                          style: Style.interNormal(
                                              size: 16,
                                              textDecoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      Text(
                                        AppHelpers.numberFormat(
                                          number: selectMaster
                                              .serviceMaster?.totalPrice,
                                        ),
                                        style: Style.interNormal(size: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.r),
                                child: Text(
                                  errors.toList().join(", "),
                                  style: Style.interNormal(
                                      color: Style.red, size: 12),
                                ),
                              ),
                              8.verticalSpace,
                              OutlinedBorderTextField(
                                label: null,
                                hintText: AppHelpers.getTranslation(
                                    TrKeys.notesAndSpecial),
                                onChanged: (text) {
                                  notifier.addNote(note: text, index: index);
                                },
                              ),
                              if (selectMaster.serviceMaster?.service?.type ==
                                  TrKeys.offlineOut)
                                Padding(
                                  padding: EdgeInsets.only(top: 8.r),
                                  child: OutlinedBorderTextField(
                                    label: null,
                                    validator: AppValidators.emptyCheck,
                                    hintText: AppHelpers.getTranslation(
                                        TrKeys.address),
                                    onChanged: (text) {
                                      notifier.addAddress(
                                          address: text, index: index);
                                    },
                                  ),
                                ),
                            ],
                          );
                        }),
                    state.isLoading
                        ? const Loading()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PriceItem(
                                title: TrKeys.subtotal,
                                price: state.calculate?.price,
                              ),
                              // PriceItem(
                              //   title: TrKeys.commissionFee,
                              //   price: state.calculate?.totalCommissionFee,
                              // ),
                              PriceItem(
                                title: TrKeys.serviceFee,
                                price: state.calculate?.totalServiceFee,
                              ),
                              if ((state.calculate?.totalDiscount ?? 0) > 0)
                                PriceItem(
                                  title: TrKeys.discount,
                                  price: state.calculate?.totalDiscount,
                                  discount: true,
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  16.verticalSpace,
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.total),
                                          style: Style.interNormal(size: 16),
                                        ),
                                        Text(
                                          AppHelpers.numberFormat(
                                              number:
                                                  state.calculate?.totalPrice),
                                          style: Style.interNormal(size: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    100.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Row(
              children: [
                PopButton(
                  popSuccess: () {
                    ref.read(bookingProvider.notifier).changeStateIndex(0);
                  },
                ),
                10.horizontalSpace,
                SizedBox(
                  height: 64.r,
                  width: 200.r,
                  child: CustomButton(
                      title: AppHelpers.getTranslation(TrKeys.next),
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          AppHelpers.showAlertDialog(
                            context: context,
                            child: BookingPaymentBottomSheet(
                              startTime: state.selectDateTime,
                            ),
                          );
                          return;
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
