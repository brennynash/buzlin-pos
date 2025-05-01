import 'package:admin_desktop/application/help/help_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/common_app_bar.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/help_item.dart';

@RoutePage()
class HelpPage extends ConsumerStatefulWidget {
  const HelpPage({super.key});

  @override
  ConsumerState<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends ConsumerState<HelpPage> {
  final bool isLtr = LocalStorage.getLangLtr();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(helpProvider.notifier).fetchHelp(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(helpProvider);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Style.backgroundColor,
        body: state.isLoading
            ? const Loading()
            : Column(
                children: [
                  CommonAppBar(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.help),
                      style: Style.interMedium(
                        size: 18,
                        color: Style.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            top: 24.h,
                            right: 16.w,
                            left: 16.w,
                            bottom:
                                MediaQuery.of(context).padding.bottom + 72.h),
                        itemCount: (state.data?.data?.length ?? 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 160.r,
                          crossAxisSpacing: 12.r,
                          mainAxisSpacing: 12.r,
                        ),
                        itemBuilder: (context, index) {
                          return HelpItem(helpData: state.data?.data?[index]);
                        }),
                  ),
                ],
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              const PopButton(),
              10.horizontalSpace,
              Expanded(
                  child: Container(
                height: 72.r,
                padding: EdgeInsets.all(12.r),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Style.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Style.textColor)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/svg/contact.svg"),
                    20.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppHelpers.getTranslation(
                                TrKeys.stillHaveQuestions),
                            style: Style.interSemi(size: 14.sp),
                          ),
                          10.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.cantFindTheAnswer),
                            style: Style.interRegular(size: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      bgColor: Style.black,
                      textColor: Style.white,
                      title: AppHelpers.getTranslation(TrKeys.callToSupport),
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: AppHelpers.getAppPhone(),
                        );
                        await launchUrl(launchUri);
                      },
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
