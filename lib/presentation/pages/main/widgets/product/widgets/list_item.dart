part of 'product_list_view.dart';

class ListItem extends StatelessWidget {
  final ProductData productData;
  final VoidCallback onSelect;
  final Function(bool?) onActive;
  final bool isSelect;
  final bool isLoading;
  final BoxConstraints constraints;

  const ListItem({
    super.key,
    required this.productData,
    required this.onSelect,
    required this.isSelect,
    required this.onActive,
    required this.isLoading,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: isSelect ? Style.mainBack : Style.white,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          child: Row(
            children: [
              CustomCheckbox(isActive: isSelect, onTap: onSelect),
              8.horizontalSpace,
              SizedBox(
                width: constraints.maxWidth / 18,
                child: Text(
                  "${productData.id ?? 0}",
                  style: Style.interNormal(
                    size: 16,
                    color: Style.brandTitleDivider,
                  ),
                ),
              ),
              12.horizontalSpace,
              CommonImage(
                url: productData.img,
                height: 50,
                width: constraints.maxWidth / 12,
              ),
              12.horizontalSpace,
              SizedBox(
                width: constraints.maxWidth / 5,
                child: Text(
                  AppHelpers.getTranslation(
                      productData.translation?.title ?? "--"),
                  style: Style.interNormal(
                    size: 16,
                    color: Style.brandTitleDivider,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              12.horizontalSpace,
              SizedBox(
                width: constraints.maxWidth / 8,
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppHelpers.getStatusColor(productData.status ?? "")
                        .withOpacity(0.16),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    AppHelpers.getTranslation(productData.status ?? "--"),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color:
                          AppHelpers.getStatusColor(productData.status ?? ""),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              12.horizontalSpace,
              if (constraints.maxWidth > 800)
                SizedBox(
                  width: constraints.maxWidth / 10,
                  child: Text(
                    productData.category?.translation?.title ?? "--",
                    maxLines: 1,
                    style: Style.interNormal(
                      size: 16,
                      color: Style.brandTitleDivider,
                    ),
                  ),
                ),
              12.horizontalSpace,
              if (constraints.maxWidth > 920)
                SizedBox(
                  width: constraints.maxWidth / 6,
                  child: Text(
                    TimeService.dateFormatMDYHm(
                        DateTime.parse(productData.createdAt ?? "").toLocal()),
                    style: Style.interNormal(
                      size: 16,
                      color: Style.brandTitleDivider,
                    ),
                  ),
                ),
              const Spacer(),
              SizedBox(
                width: constraints.maxWidth / 12,
                child: CustomToggle(
                  width: constraints.maxWidth < 800
                      ? constraints.maxWidth / 12
                      : 70,
                  controller: ValueNotifier(productData.active ?? false),
                  onChange: isLoading == false ? onActive : null,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: constraints.maxWidth / 22,
                child: ProductPopup(productData: productData),
              ),
            ],
          ),
        ),
        Divider(height: 2.r),
      ],
    );
  }
}
