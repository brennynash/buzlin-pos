part of 'custom_dropdown.dart';

const _headerPadding = EdgeInsets.only(
  left: 16.0,
  top: 16,
  bottom: 16,
  right: 14,
);
const _overlayOuterPadding = EdgeInsets.only(bottom: 12, left: 12, right: 12);
const _overlayShadowOffset = Offset(0, 6);

class _DropdownOverlay extends ConsumerStatefulWidget {
  final DropDownType dropDownType;
  final TextEditingController controller;
  final Size size;
  final LayerLink layerLink;
  final VoidCallback hideOverlay;
  final String hintText;
  final String searchHintText;
  final Function(String)? onChanged;
  final bool isOrdering;

  const _DropdownOverlay({
    required this.dropDownType,
    required this.controller,
    required this.size,
    required this.layerLink,
    required this.hideOverlay,
    required this.hintText,
    required this.searchHintText,
    required this.onChanged,
    this.isOrdering = true,
  });

  @override
  ConsumerState<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends ConsumerState<_DropdownOverlay> {
  bool displayOverly = true;
  bool displayOverlayBottom = true;
  final key1 = GlobalKey(), key2 = GlobalKey();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final render1 = key1.currentContext?.findRenderObject() as RenderBox;
      final render2 = key2.currentContext?.findRenderObject() as RenderBox;
      final screenHeight = MediaQuery.sizeOf(context).height;
      double y = render1.localToGlobal(Offset.zero).dy;
      if (screenHeight - y < render2.size.height) {
        displayOverlayBottom = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final rightSideState = ref.watch(rightSideProvider);
    final createBookingsState = ref.watch(createBookingProvider);
    final notifier = ref.read(orderDetailsProvider.notifier);
    final rightSideNotifier = ref.read(rightSideProvider.notifier);
    final createBookingsNotifier = ref.read(createBookingProvider.notifier);
    final acceptedMastersNotifier = ref.read(acceptedMastersProvider.notifier);
    final acceptedMastersState = ref.watch(acceptedMastersProvider);
    final bookingsNotifier = ref.watch(bookingProvider.notifier);
    // overlay icon
    final overlayIcon = Icon(
      displayOverlayBottom
          ? Icons.keyboard_arrow_up_rounded
          : Icons.keyboard_arrow_down_rounded,
      color: Colors.black,
      size: 20,
    );

    // overlay offset
    final overlayOffset = Offset(-12, displayOverlayBottom ? 0 : 60);

    final isLoadingItems = (widget.dropDownType == DropDownType.categories
        ? state.isUsersLoading
        : widget.dropDownType == DropDownType.masters
            ? acceptedMastersState.isLoading
            : widget.isOrdering
                ? rightSideState.isUsersLoading
                : createBookingsState.isUserLoading);
    final List<DropDownItemData> items =
        (widget.dropDownType == DropDownType.categories
            ? state.dropdownUsers
            : widget.dropDownType == DropDownType.masters
                ? acceptedMastersState.dropdownUsers
                : widget.isOrdering
                    ? rightSideState.dropdownUsers
                    : createBookingsState.dropdownUsers);
    final list = items.isNotEmpty
        ? _ItemsList(
            dropDownType: widget.dropDownType,
            scrollController: scrollController,
            items: items,
            onItemSelect: (value) {
              widget.controller.text = value.title;
              setState(() => displayOverly = false);
              switch (widget.dropDownType) {
                case DropDownType.categories:
                  notifier.setSelectedUser(context, value.index);
                  break;
                case DropDownType.users:
                  if (widget.isOrdering) {
                    rightSideNotifier.setSelectedUser(context, value.index);
                  } else {
                    createBookingsNotifier.setSelectedUser(
                        context, value.index);
                  }
                  break;
                case DropDownType.masters:
                  bookingsNotifier.changeMaster(id: value.id, context: context);
                  break;
              }
            },
          )
        : Center(
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 12),
              child: Text(
                AppHelpers.getTranslation(TrKeys.noSearchResults),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Style.searchHint,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -14 * 0.02,
                ),
              ),
            ),
          );

    final child = Stack(
      children: [
        Positioned(
          width: 291.r,
          child: CompositedTransformFollower(
            link: widget.layerLink,
            followerAnchor:
                displayOverlayBottom ? Alignment.topLeft : Alignment.bottomLeft,
            showWhenUnlinked: false,
            offset: overlayOffset,
            child: Container(
              key: key1,
              padding: _overlayOuterPadding,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Style.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24.0,
                      color: Colors.black.withOpacity(.08),
                      offset: _overlayShadowOffset,
                    ),
                  ],
                ),
                child: Material(
                  color: Style.transparent,
                  child: AnimatedSection(
                    animationDismissed: widget.hideOverlay,
                    expand: displayOverly,
                    axisAlignment: displayOverlayBottom ? 1.0 : -1.0,
                    child: SizedBox(
                      key: key2,
                      height: items.length > 4 ? 312.r : null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (notification) {
                            notification.disallowIndicator();
                            return true;
                          },
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              scrollbarTheme: ScrollbarThemeData(
                                thumbVisibility: WidgetStateProperty.all(
                                  true,
                                ),
                                thickness: WidgetStateProperty.all(5),
                                radius: const Radius.circular(4),
                                thumbColor: WidgetStateProperty.all(
                                  Colors.grey[300],
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: _headerPadding,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.hintText,
                                          style: GoogleFonts.inter(
                                            color: Style.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.4,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      overlayIcon,
                                    ],
                                  ),
                                ),
                                _SearchField(
                                  items: items,
                                  searchHintText: widget.searchHintText,
                                  onChanged: widget.onChanged,
                                  onCleared: () {
                                    switch (widget.dropDownType) {
                                      case DropDownType.categories:
                                        notifier.setUsersQuery(context, '');
                                        break;
                                      case DropDownType.users:
                                        if (widget.isOrdering) {
                                          rightSideNotifier.setUsersQuery(
                                              context, '');
                                        } else {
                                          createBookingsNotifier.setUsersQuery(
                                              context, '');
                                        }
                                        break;
                                      case DropDownType.masters:
                                        acceptedMastersNotifier.setMastersQuery(
                                            context, '');
                                        break;
                                    }
                                  },
                                ),
                                isLoadingItems
                                    ? Padding(
                                        padding:
                                            REdgeInsets.symmetric(vertical: 16),
                                        child: Center(
                                          child: SizedBox(
                                            width: 18.r,
                                            height: 18.r,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.r,
                                              color: Style.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    : items.length > 4
                                        ? Expanded(child: SingleChildScrollView(child: list))
                                        : list
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: () => setState(() => displayOverly = false),
      child: child,
    );
  }
}

class _ItemsList extends StatelessWidget {
  final ScrollController scrollController;
  final List<DropDownItemData> items;
  final ValueSetter<DropDownItemData> onItemSelect;
  final DropDownType dropDownType;

  const _ItemsList({
    required this.scrollController,
    required this.items,
    required this.onItemSelect,
    required this.dropDownType,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: dropDownType == DropDownType.masters
            ? items.length + 1
            : items.length,
        itemBuilder: (_, index) {
          if (dropDownType == DropDownType.masters && index == 0) {
            return Padding(
              padding: REdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Style.transparent,
                    child: InkWell(
                      splashColor: Style.transparent,
                      onTap: () => onItemSelect(DropDownItemData(
                        id: -1,
                        title: AppHelpers.getTranslation(TrKeys.all),
                        index: -1,
                      )),
                      child: Container(
                        padding: REdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.all),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Style.searchHint,
                            letterSpacing: -14 * 0.02,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.r,
                    thickness: 1.r,
                    color: Style.unselectedBottomBarBack,
                  )
                ],
              ),
            );
          } else {
            final adjustedIndex =
                dropDownType == DropDownType.masters ? index - 1 : index;
            return Padding(
              padding: REdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Style.transparent,
                    child: InkWell(
                      splashColor: Style.transparent,
                      onTap: () => onItemSelect(items[adjustedIndex]),
                      child: Container(
                        padding: REdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        child: Text(
                          items[adjustedIndex].title,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Style.searchHint,
                            letterSpacing: -14 * 0.02,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.r,
                    thickness: 1.r,
                    color: Style.unselectedBottomBarBack,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  final String searchHintText;
  final List<DropDownItemData> items;
  final Function(String)? onChanged;
  final Function() onCleared;

  const _SearchField({
    required this.searchHintText,
    required this.items,
    required this.onChanged,
    required this.onCleared,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final searchCtrl = TextEditingController();

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void onClear() {
    if (searchCtrl.text.isNotEmpty) {
      searchCtrl.clear();
      widget.onCleared();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 64.r,
        child: TextField(
          controller: searchCtrl,
          onChanged: (value) {
            widget.onChanged!(value);
            debugPrint('===> search field value: $value');
          },
          cursorWidth: 1.r,
          cursorColor: Style.searchHint,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Style.searchHint,
            fontWeight: FontWeight.w400,
            letterSpacing: -14 * 0.02,
          ),
          decoration: InputDecoration(
            fillColor: Style.dontHaveAccBtnBack,
            filled: true,
            constraints: BoxConstraints.tightFor(height: 40.r),
            hoverColor: Style.transparent,
            hintText: widget.searchHintText,
            contentPadding: EdgeInsets.zero,
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Style.black.withOpacity(0.4),
              fontWeight: FontWeight.w400,
              letterSpacing: -14 * 0.02,
            ),
            prefixIcon: Icon(
              Remix.search_line,
              color: Style.black,
              size: 20.r,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Remix.close_circle_line,
                size: 20.r,
                color: Style.black.withOpacity(0.5),
              ),
              splashColor: Style.transparent,
              hoverColor: Style.transparent,
              onPressed: onClear,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: Style.transparent,
                width: 0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: Style.transparent,
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: Style.transparent,
                width: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
