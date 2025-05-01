part of 'product_list_view.dart';

class ListTopBar extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;
  final VoidCallback onRefresh;
  final bool isLoading;
  final bool isActive;

  const ListTopBar({
    super.key,
    required this.title,
    required this.count,
    required this.onTap,
    required this.isLoading,
    required this.isActive,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 64,
        decoration: BoxDecoration(
          color: isActive ? Style.white : Style.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppHelpers.getTranslation(title),
                style: Style.interMedium(size: 16),
              ),
              12.horizontalSpace,
              if (isActive)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppHelpers.getStatusColor(title),
                  ),
                  child: Text(
                    count.toString(),
                    style: Style.interMedium(size: 16, color: Style.white),
                  ),
                ),
              12.horizontalSpace,
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: isActive
                    ? GestureDetector(
                        onTap: onRefresh,
                        child: isLoading
                            ? Lottie.asset(
                                Assets.lottieRefresh,
                                width: 32,
                                height: 32,
                                fit: BoxFit.fill,
                              )
                            : const Icon(Remix.refresh_line),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
