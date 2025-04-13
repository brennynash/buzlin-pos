// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../../../core/constants/tr_keys.dart';
// import '../../../../../../../../core/utils/app_helpers.dart';
// import '../../../../../../../../core/utils/utils.dart';
// import '../../../../../../../../models/response/transaction_histories_response.dart';
// import '../../../../../../../theme/style.dart';
//
// class TransactionItem extends StatelessWidget {
//   final TransactionModel transaction;
//
//   const TransactionItem({super.key, required this.transaction});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 8.r, left: 16.r, right: 16.r),
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 22.r),
//       decoration: BoxDecoration(
//         color: Style.white,
//         borderRadius: BorderRadius.circular(10.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 DateService.dateFormatForNotification(transaction.createdAt),
//                 style: Style.interNormal(color: Style.textHint, size: 12),
//               ),
//             ],
//           ),
//           12.verticalSpace,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 AppHelpers.getTranslation(TrKeys.sender),
//                 style: Style.interRegular(),
//               ),
//               Text(
//                 transaction.author?.firstname ?? "",
//                 style: Style.interRegular(),
//               )
//             ],
//           ),
//           if (transaction.note != null)
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 6.verticalSpace,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       AppHelpers.getTranslation(TrKeys.note),
//                       style: Style.interRegular(),
//                     ),
//                     16.horizontalSpace,
//                     Expanded(
//                       child: AutoSizeText(
//                         transaction.note ?? "",
//                         style: Style.interRegular(size: 14),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           12.verticalSpace,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 AppHelpers.getTranslation(
//                     transaction.transactionData?.tag ?? TrKeys.price),
//                 style: Style.interRegular(),
//               ),
//               Text(
//                 transaction.type == "withdraw"
//                     ? "-${AppHelpers.numberFormat(number: transaction.price)}"
//                     : AppHelpers.numberFormat(number: transaction.price),
//                 style: Style.interRegular(),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
