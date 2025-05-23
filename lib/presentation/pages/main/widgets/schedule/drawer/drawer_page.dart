// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:venderuzmart/application/providers.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:venderuzmart/presentation/styles/style.dart';
// import 'package:venderuzmart/infrastructure/services/services.dart';
// import 'package:venderuzmart/presentation/component/components.dart';
//
// class DrawerPage extends ConsumerStatefulWidget {
//   const DrawerPage({super.key});
//
//   @override
//   ConsumerState<DrawerPage> createState() => _DrawerPageState();
// }
//
// class _DrawerPageState extends ConsumerState<DrawerPage> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (ref.read(acceptedMastersProvider).users.isEmpty) {
//         ref
//             .read(acceptedMastersProvider.notifier)
//             .fetchMembers(isRefresh: true, context: context);
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mastersState = ref.watch(acceptedMastersProvider);
//     final state = ref.watch(bookingProvider);
//     final notifier = ref.read(bookingProvider.notifier);
//
//     return KeyboardDismisser(
//       child: Padding(
//         padding: EdgeInsets.only(left: 10.r, bottom: 16.r),
//         child: BlurWrap(
//           radius: BorderRadius.horizontal(
//             left: Radius.circular(AppConstants.radius.r),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Style.white.withOpacity(0.95),
//               borderRadius: BorderRadius.horizontal(
//                 left: Radius.circular(AppConstants.radius.r),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   MediaQuery.paddingOf(context).top.verticalSpace,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                            context.maybePop();
//                         },
//                         icon: const Icon(Icons.close),
//                       ),
//                     ],
//                   ),
//                   12.verticalSpace,
//                   Padding(
//                     padding: REdgeInsets.only(left: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           AppHelpers.getTranslation(TrKeys.calendarView),
//                           style: Style.interSemi(size: 18),
//                         ),
//                         16.verticalSpace,
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: List.generate(
//                                 3,
//                                 (index) => Padding(
//                                       padding: REdgeInsets.only(right: 24),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           notifier.changeCalendarType(
//                                             index: index,
//                                             context: context,
//                                           );
//                                         },
//                                         child: Column(
//                                           children: [
//                                             AbsorbPointer(
//                                               child: CircleButton(
//                                                 size: 40,
//                                                 borderColor:
//                                                     state.calendarType == index
//                                                         ? Style.primary
//                                                         : Style.colorGrey,
//                                                 backgroundColor:
//                                                     state.calendarType == index
//                                                         ? Style.primary
//                                                         : Style.greyColor,
//                                                 iconColor:
//                                                     state.calendarType == index
//                                                         ? Style.white
//                                                         : Style.black,
//                                                 icon: index == 0
//                                                     ? Icons.view_day_outlined
//                                                     : index == 1
//                                                         ? Icons
//                                                             .width_normal_outlined
//                                                         : Icons
//                                                             .calendar_view_week,
//                                                 onTap: () {},
//                                               ),
//                                             ),
//                                             8.verticalSpace,
//                                             Text(
//                                               AppHelpers.getTranslation(
//                                                 index == 0
//                                                     ? TrKeys.day
//                                                     : index == 1
//                                                         ? TrKeys.threeDay
//                                                         : TrKeys.week,
//                                               ),
//                                               style:
//                                                   Style.interRegular(size: 14),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ))),
//                         24.verticalSpace,
//                         Text(
//                           AppHelpers.getTranslation(TrKeys.masters),
//                           style: Style.interSemi(size: 18),
//                         ),
//                         12.verticalSpace,
//                       ],
//                     ),
//                   ),
//                   _filterItem(
//                     isActive: state.selectMaster == -1,
//                     title: TrKeys.all,
//                     icon: Remix.team_line,
//                     onTap: () {
//                       notifier.changeMaster(id: -1, context: context);
//                     },
//                   ),
//                   // _filterItem(
//                   //   isActive: state.selectMaster == 1,
//                   //   title: TrKeys.working,
//                   //   icon: Remix.briefcase_line,
//                   //   onTap: () {
//                   //     notifier.changeMaster(id: 1, context: context);
//                   //   },
//                   // ),
//                   ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     itemCount: mastersState.users.length,
//                     itemBuilder: (context, index) => UserItem(
//                       user: mastersState.users[index],
//                       onTap: () {
//                         notifier.changeMaster(
//                             id:  mastersState.users[index].id, context: context);
//                       },
//                       isSelected: state.selectMaster ==  mastersState.users[index].id,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _filterItem({
//     required bool isActive,
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 68.r,
//         margin: REdgeInsets.only(bottom: 6),
//         decoration: BoxDecoration(
//           color: isActive ? Style.primary.withOpacity(0.08) : Style.white,
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               margin: REdgeInsets.symmetric(vertical: 12),
//               width: 4,
//               decoration: ShapeDecoration(
//                 color: isActive ? Style.primary : Style.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(10.r),
//                     bottomRight: Radius.circular(10.r),
//                   ),
//                 ),
//               ),
//             ),
//             12.horizontalSpace,
//             Container(
//               padding: REdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.r),
//                 color: Style.black.withOpacity(0.05),
//               ),
//               // alignment: Alignment.center,
//               child: Container(
//                 height: 40.r,
//                 width: 40.r,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Style.primary.withOpacity(0.06)),
//                 child: Icon(
//                   icon,
//                   color: Style.primary,
//                   size: 21.r,
//                 ),
//               ),
//             ),
//             10.horizontalSpace,
//             Expanded(
//               child: Text(
//                 AppHelpers.getTranslation(title),
//                 style: Style.interSemi(size: 15),
//               ),
//             ),
//             16.horizontalSpace,
//           ],
//         ),
//       ),
//     );
//   }
// }
