import 'package:admin_desktop/domain/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'city_modal.dart';

class CountryModal extends ConsumerStatefulWidget {
  final int bagIndex;

  const CountryModal({
    super.key,
    required this.bagIndex,
  });

  @override
  ConsumerState<CountryModal> createState() => _CountryPageState();
}

class _CountryPageState extends ConsumerState<CountryModal> {
  final RefreshController controller = RefreshController();
  final Delayed delayed = Delayed(milliseconds: 700);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(addressProvider.notifier)
          .fetchCountry(context: context, isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addressProvider);
    final notifier = ref.read(addressProvider.notifier);
    return KeyboardDisable(
      child: ListView(
        children: [
          Row(
            children: [
              18.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.selectCountry),
                style: Style.interSemi(size: 18),
              ),
              const Spacer(),
              IconButton(
                  splashRadius: 5.r,
                  onPressed: () {
                    context.maybePop();
                  },
                  icon: const Icon(Remix.close_line))
            ],
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: OutlinedBorderTextField(
              label: null,
              hintText: AppHelpers.getTranslation(TrKeys.search),
              onChanged: (s) {
                if (s.trim().isNotEmpty) {
                  delayed.run(() {
                    notifier.searchCountry(context: context, search: s);
                  });
                }
              },
            ),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(16.r),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.8.r,
              crossAxisCount: 4,
              mainAxisSpacing: 12.r,
              crossAxisSpacing: 8.r,
              mainAxisExtent: 60.r,
            ),
            itemCount: state.countries.length,
            itemBuilder: (context, index) {
              return _countryItem(state.countries[index]);
            },
          ),
          state.isCountryLoading
              ? const LocationGridListShimmer(
                  count: 4,
                )
              : state.hasMoreCountry && state.countries.isNotEmpty
                  ? ViewMoreButton(
                      onTap: () {
                        notifier.fetchCountry(context: context);
                      },
                    )
                  : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _countryItem(CountryData country) {
    final pickupAddress = LocalStorage.getBags()[widget.bagIndex].pickupAddress;

    return ButtonEffectAnimation(
      onTap: () {
        ref.read(rightSideProvider.notifier).setCountry(country);
        ref.read(addressProvider.notifier).setCountryId(country.id!);
         context.maybePop();
        if ((country.citiesCount ?? 0) > 0) {
          AppHelpers.showAlertDialog(
            context: context,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).width * .8,
              width: MediaQuery.sizeOf(context).width / 2 * 3,
              child: CityModal(
                countryId: country.id ?? 0,
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Style.bg,
          border: Border.all(
              color: pickupAddress?.country?.id == country.id
                  ? Style.primary
                  : Style.icon),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonImage(
                url: country.img ?? "",
                height: 20,
                width: 30,
                radius: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: AutoSizeText(
                  country.translation?.title ?? "",
                  style: Style.interNormal(size: 12),
                  minFontSize: 6,
                  maxFontSize: 14,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
