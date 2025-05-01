part of 'brand_list_view.dart';

class BrandListItem extends StatelessWidget {
  final Brand brandData;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final bool isSelect;
  final bool isLoading;
  final BoxConstraints constraints;

  const BrandListItem({
    super.key,
    required this.brandData,
    required this.onSelect,
    required this.isSelect,
    required this.isLoading,
    required this.onEdit,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: isSelect ? Style.mainBack : Style.white,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18.r),
            child: Row(
              children: [
                CustomCheckbox(isActive: isSelect, onTap: onSelect),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 19,
                  child: Text(
                    "${brandData.id ?? 0}",
                    style: Style.interRegular(color: Style.textColor),
                  ),
                ),
                8.horizontalSpace,
                CommonImage(
                  isResponsive: false,
                  url: brandData.img,
                  height: 50,
                  width: constraints.maxWidth / 12,
                  fit: BoxFit.contain,
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 4,
                  child: Text(
                    AppHelpers.getTranslation(brandData.title ?? "--"),
                    style: Style.interRegular(color: Style.textColor),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 4,
                  child: Text(
                    TimeService.dateFormatMDYHm(brandData.createdAt),
                    style: Style.interRegular(color: Style.textColor),
                  ),
                ),
                8.horizontalSpace,
                if (constraints.maxWidth > 880)
                SizedBox(
                  width: constraints.maxWidth / 9,
                  child: Text(
                    AppHelpers.getTranslation(AppHelpers.getTranslation(
                        (brandData.active ?? false)
                            ? TrKeys.active
                            : TrKeys.inactive)),
                    style: Style.interRegular(color: Style.textColor),
                  ),
                ),
                const Spacer(),
                brandData.shopId != null &&
                        brandData.shopId == LocalStorage.getUser()?.shop?.id
                    ? ButtonEffectAnimation(
                        child: InkWell(
                          onTap: onEdit,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: REdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Style.primary,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Remix.edit_2_line,
                              color: Style.white,
                              size: 24,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                12.horizontalSpace,
              ],
            ),
          ),
        ),
        const Divider(height: 2),
      ],
    );
  }
}
