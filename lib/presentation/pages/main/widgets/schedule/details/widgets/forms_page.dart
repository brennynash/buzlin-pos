import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import '../../../../../../../application/bookings/details/booking_details_provider.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class FormsPage extends ConsumerWidget {
  const FormsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(bookingDetailsProvider);
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: state.bookingData?.forms?.length ?? 0,
        itemBuilder: (context, index) {
          final form = state.bookingData?.forms?[index];
          return Container(
            margin: REdgeInsets.only(bottom: 6),
            padding: REdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Style.borderColor,
                borderRadius: BorderRadius.circular(AppConstants.radius / 1.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  form?.translation?.title ?? '',
                  style: Style.interNormal(size: 15),
                ),
                12.verticalSpace,
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: form?.data?.length ?? 0,
                    itemBuilder: (context, i) {
                      return _questions(form?.data?[i], i, context);
                    }),
              ],
            ),
          );
        });
  }

  Widget _questions(QuestionData? form, int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.r),
      decoration: BoxDecoration(
          color: Style.whiteWithOpacity,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Style.icon)),
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            form?.question ?? "",
          ),
          16.verticalSpace,
          if (form?.answerType == TrKeys.shortAnswer)
            OutlinedBorderTextField(
              initialText: form?.userAnswer?.join(),
              // hintText: AppHelpers.getTranslation(TrKeys.shortAnswer),
              onChanged: (s) {},
              readOnly: true,
              label: null,
            ),
          if (form?.answerType == TrKeys.longAnswer)
            OutlinedBorderTextField(
              initialText: form?.userAnswer?.join(),
              // hintText: AppHelpers.getTranslation(TrKeys.longAnswer),
              label: null,
              readOnly: true,
            ),
          if (form?.answerType == TrKeys.singleAnswer)
            ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: form?.answer?.length ?? 0,
                itemBuilder: (context, answerIndex) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            form?.userAnswer?.contains(
                                        form.answer?[answerIndex] ?? "") ??
                                    false
                                ? Remix.checkbox_blank_circle_fill
                                : Remix.checkbox_blank_circle_line,
                          )),
                      8.horizontalSpace,
                      Text(
                        form?.answer?[answerIndex] ?? "",
                        style: Style.interRegular(),
                      )
                    ],
                  );
                }),
          if (form?.answerType == TrKeys.multipleChoice)
            ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: form?.answer?.length ?? 0,
                itemBuilder: (context, answerIndex) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            form?.userAnswer?.contains(
                                        form.answer?[answerIndex] ?? "") ??
                                    false
                                ? Remix.checkbox_blank_circle_fill
                                : Remix.checkbox_blank_circle_line,
                          )),
                      8.horizontalSpace,
                      Text(
                        form?.answer?[answerIndex] ?? "",
                        style: Style.interRegular(),
                      )
                    ],
                  );
                }),
          if (form?.answerType == TrKeys.dropDown)
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 80.r,
              child: OutlineDropDown(
                  hint: TrKeys.selectAnswer,
                  value: (form?.userAnswer?.isEmpty ?? true)
                      ? null
                      : form?.userAnswer?.first,
                  list: form?.answer?.toList() ?? [],
                  onChanged: (v) {}),
            ),
          if (form?.answerType == TrKeys.yesOrNo)
            ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, answerIndex) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            form?.userAnswer?.contains(
                                        answerIndex == 0 ? true : false) ??
                                    false
                                ? Remix.checkbox_blank_circle_fill
                                : Remix.checkbox_blank_circle_line,
                          )),
                      8.horizontalSpace,
                      Text(
                        answerIndex == 0
                            ? AppHelpers.getTranslation(TrKeys.yes)
                            : AppHelpers.getTranslation(TrKeys.no),
                        style: Style.interRegular(),
                      )
                    ],
                  );
                }),
        ],
      ),
    );
  }
}
