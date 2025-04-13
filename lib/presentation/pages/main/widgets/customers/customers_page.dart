import 'package:admin_desktop/presentation/pages/main/widgets/customers/components/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'components/custom_add_customer_dialog.dart';
import 'components/customers_list.dart';
import 'view_customer.dart';

class CustomersPage extends ConsumerStatefulWidget {
  const CustomersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomersPageState();
}

class _CustomersPageState extends ConsumerState<CustomersPage> {
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    ref.read(customerProvider.notifier).fetchAllUsers();

    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(customerProvider.notifier);
    final state = ref.watch(customerProvider);
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 3.r,
                color: Style.black,
              ),
            )
          : state.selectUser == null
              ? state.users.isNotEmpty
                  ? ListView(
                      padding: REdgeInsets.only(top: 16),
                      shrinkWrap: true,
                      children: [
                        state.query.isNotEmpty
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.customers),
                                    style: Style.interMedium(size: 22.sp),
                                  ),
                                  ConfirmButton(
                                    prefixIcon: Icon(
                                      Icons.add,
                                      size: 24.r,
                                      color: Style.white,
                                    ),
                                    title: TrKeys.addCustomer,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) =>
                                            const AddCustomerDialog(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                        16.verticalSpace,
                        InkWell(
                          onTap: () => notifier.setUser(state.users.first),
                          child: state.query.isNotEmpty
                              ? const SizedBox.shrink()
                              : Container(
                                  height: 164.r,
                                  decoration: BoxDecoration(
                                      color: Style.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Row(
                                    children: [
                                      16.horizontalSpace,
                                      CommonImage(
                                        width: 108,
                                        height: 108,
                                        radius: 54,
                                        url: state.users.first.img ?? '',
                                      ),
                                      20.horizontalSpace,
                                      Padding(
                                        padding: REdgeInsets.only(top: 41),
                                        child: Padding(
                                          padding: REdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${state.users.first.firstname ?? ""} ${state.users.first.lastname?.substring(0, 1) ?? ""}.',
                                                    style: GoogleFonts.inter(
                                                        fontSize: 24.sp,
                                                        color: Style.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  12.horizontalSpace,
                                                  Text(
                                                    '#${AppHelpers.getTranslation(TrKeys.id)}${state.users.first.id}',
                                                    style: Style.interNormal(
                                                      size: 16.sp,
                                                      color: Style.iconColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              12.verticalSpace,
                                              Text(
                                                state.users.first.email ?? '',
                                                style: Style.interNormal(
                                                  size: 14.sp,
                                                  color: Style.iconColor,
                                                ),
                                              ),
                                              6.verticalSpace,
                                              Text(
                                                state.users.first.phone ?? '',
                                                style: Style.interNormal(
                                                  size: 14.sp,
                                                  color: Style.iconColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        state.query.isNotEmpty
                            ? 1.verticalSpace
                            : 16.verticalSpace,
                        Container(
                          width: double.infinity,
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Style.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              16.verticalSpace,
                              Text(
                                state.query.isNotEmpty
                                    ? AppHelpers.getTranslation(
                                        TrKeys.searchResults)
                                    : AppHelpers.getTranslation(
                                        TrKeys.recentCustomers),
                                style: Style.interMedium(size: 22.sp),
                              ),
                              8.verticalSpace,
                              Column(
                                children: [
                                  AnimationLimiter(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.query.isNotEmpty
                                          ? state.users.length
                                          : state.users.length - 1,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              InkWell(
                                        onTap: () {
                                          notifier.setUser(
                                              state.query.isNotEmpty
                                                  ? state.users[index]
                                                  : state.users[index + 1]);
                                        },
                                        child: AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 375),
                                          child: FadeInAnimation(
                                            child: SlideAnimation(
                                              child: CustomersList(
                                                imageUrl: state.query.isNotEmpty
                                                    ? state.users[index].img
                                                    : state.users[index + 1]
                                                            .img ??
                                                        '',
                                                name: state.query.isNotEmpty
                                                    ? state
                                                        .users[index].firstname
                                                    : state.users[index + 1]
                                                            .firstname ??
                                                        '',
                                                lastname: state.query.isNotEmpty
                                                    ? state
                                                        .users[index].lastname
                                                    : state.users[index + 1]
                                                            .lastname ??
                                                        '',
                                                gmail: state.query.isNotEmpty
                                                    ? state.users[index].email
                                                    : state.users[index + 1]
                                                            .email ??
                                                        '',
                                                date: state.query.isNotEmpty
                                                    ? state.users[index]
                                                        .registeredAt
                                                        .toString()
                                                    : state.users[index + 1]
                                                        .registeredAt
                                                        .toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  24.verticalSpace,
                                  state.isMoreLoading
                                      ? const LineShimmer(
                                          isActiveLine: false,
                                        )
                                      : state.hasMore && state.users.isNotEmpty
                                          ? ViewMoreButton(
                                              onTap: () {
                                                notifier.fetchAllUsers();
                                              },
                                            )
                                          : const SizedBox(),
                                  24.verticalSpace,
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : const Center(child: NotFound())
              : ViewCustomer(
                  user: state.selectUser,
                  back: () {
                    notifier.setUser(null);
                  },
                ),
    );
  }
}
