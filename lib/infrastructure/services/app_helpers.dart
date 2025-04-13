import 'dart:io';
import 'package:admin_desktop/app_constants.dart';
import 'package:colornames/colornames.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:admin_desktop/domain/models/models.dart';
import '../../presentation/components/buttons/custom_button.dart';
import 'enums.dart';
import 'local_storage.dart';
import 'tr_keys.dart';

class AppHelpers {
  AppHelpers._();

  static String get getUserRole => LocalStorage.getUser()?.role ?? 'seller';

  static getPhotoGallery(ValueChanged<String> onChange) async {
    if (Platform.isMacOS) {
      FilePickerResult? result;
      try {
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result?.files.first.path != null) {
          onChange.call(result?.files.first.path ?? "");
        }
      } catch (e, s) {
        debugPrint('===> trying to select file $e $s');
      }
    } else {
      XFile? file;
      try {
        file = await ImagePicker().pickImage(source: ImageSource.gallery);
      } catch (ex) {
        debugPrint('===> trying to select image $ex');
      }
      if (file != null) {
        onChange.call(file.path);
      }
    }
  }
  static String? getAppPhone() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'phone') {
        return setting.value;
      }
    }
    return '';
  }

  static BookingStatus getUpdatableBookingStatus(String? value) {
    switch (value) {
      case 'new':
        return BookingStatus.booked;
      case 'booked':
        return BookingStatus.progress;
      case 'progress':
        return BookingStatus.ended;
      default:
        return BookingStatus.booked;
    }
  }

  static String getBookingStatus(BookingStatus value) {
    switch (value) {
      case BookingStatus.newOrder:
        return TrKeys.newOrder;
      default:
        return value.name;
    }
  }

  static Future getVideoGallery(ValueChanged<String> onChange) async {
    XFile? file;
    try {
      file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    } catch (ex) {
      debugPrint('===> trying to select image $ex');
    }
    if (file != null) {
      onChange.call(file.path);
    }
  }

  static void showCustomModalBottomSheet({
    required BuildContext context,
    required Widget modal,
    double radius = 16,
    bool isDrag = true,
    bool isDismissible = true,
    double paddingTop = 200,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - paddingTop.r,
      ),
      backgroundColor: Style.transparent,
      context: context,
      builder: (context) =>
          Padding(padding: MediaQuery.viewInsetsOf(context), child: modal),
    );
  }

  static String changeBookingStatusButtonText(String? value) {
    switch (value) {
      case 'new':
        return getTranslation(TrKeys.changeToBooked);
      case 'booked':
        return getTranslation(TrKeys.changeTopProgress);
      case 'progress':
        return getTranslation(TrKeys.changeTopEnded);
      default:
        return getTranslation(TrKeys.changeToBooked);
    }
  }


  static Color getServiceStatusColor(String? value) {
    switch (value) {
      case 'new':
        return Style.blueColor;
      case 'accepted':
        return Style.green;
      case 'null':
      case 'canceled':
      case 'cancel':
        return Style.red;
      default:
        return Style.primary;
    }
  }

  static List<String> getMasterStatuses(String value) {
    switch (value) {
      case TrKeys.newKey:
        return [TrKeys.accepted, TrKeys.rejected];
      case TrKeys.accepted:
        return [TrKeys.newKey, TrKeys.rejected];
      case TrKeys.rejected:
        return [TrKeys.newKey, TrKeys.accepted];
      default:
        return [];
    }
  }

  static String? getAppName() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'title') {
        return setting.value;
      }
    }
    return '';
  }

  static int getType() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'ui_type') {
        return (int.tryParse(setting.value ?? "1") ?? 1) - 1;
      }
    }
    return 0;
  }

  static String getNameColor(String? value) {
    if (checkIfHex(value)) {
      final color = Color(int.parse('0xFF${value?.substring(1, 7)}'));
      return color.colorName;
    }
    return value ?? TrKeys.unKnow;
  }

  static bool getQuestionAnswer(String? value) {
    switch (value) {
      case 'single_answer':
      case 'multiple_choice':
      case 'drop_down':
        return true;
      default:
        return false;
    }
  }

  static stockHandler(
    e, {
    int bagIndex = 0,
    VoidCallback? success,
  }) async {
    try {
      final msg = errorHandler(e);
      final temp = msg.substring(msg.indexOf('.') + 1);
      int? index = int.tryParse(temp.substring(0, temp.indexOf('.')));
      if (index == null) {
        return;
      }
      final bags = LocalStorage.getBags();
      final bagProduct = bags[bagIndex].bagProducts;
      bagProduct?.removeAt(index);
      bags[bagIndex] = bags[bagIndex].copyWith(bagProducts: bagProduct);
      await LocalStorage.setBags(bags);
      success?.call();
    } catch (s) {
      return;
    }
  }

  static successSnackBar(BuildContext context, {String? text}) {
    Fluttertoast.showToast(
      msg: text ?? AppHelpers.getTranslation(TrKeys.successfullyCompleted),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Style.primary,
      textColor: Style.white,
      fontSize: 16.0,
    );
  }

  static errorSnackBar(BuildContext context, {required String text}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Style.red,
        textColor: Style.white,
        fontSize: 16.0);
  }

  static openDialog({
    required BuildContext context,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
            backgroundColor: Style.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              width: MediaQuery.sizeOf(context).width/3,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Style.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      getTranslation(title),
                      textAlign: TextAlign.center,
                      style: Style.interNormal(size: 20),
                    ),
                    24.verticalSpace,
                    CustomButton(
                      onTap: () => Navigator.pop(context),
                      title: getTranslation(TrKeys.close),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  static String numberFormat({num? number, String? symbol, bool? isOrder}) {
    number = number ?? 0;
    if (LocalStorage.getSelectedCurrency()?.position == "before") {
      return NumberFormat.currency(
        locale: LocalStorage.getLanguage()?.locale,
        customPattern: '\u00a4 #,###.#',
        symbol: (isOrder ?? false)
            ? (symbol ?? LocalStorage.getSelectedCurrency()?.symbol)
            : LocalStorage.getSelectedCurrency()?.symbol,
        decimalDigits: number > 99999 ? 0 : 2,
      ).format(number);
    } else {
      return NumberFormat.currency(
        locale: LocalStorage.getLanguage()?.locale,
        customPattern: '#,###.# \u00a4',
        symbol: (isOrder ?? false)
            ? (symbol ?? LocalStorage.getSelectedCurrency()?.symbol)
            : LocalStorage.getSelectedCurrency()?.symbol,
        decimalDigits: number > 99999 ? 0 : 2,
      ).format(number);
    }
  }

  static String? getInitialLocale() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'lang') {
        return setting.value;
      }
    }
    return null;
  }

  static bool checkIsSvg(String? url) {
    if (url == null) {
      return false;
    }
    final length = url.length;
    return length > 3 ? url.substring(length - 3, length) == 'svg' : false;
  }

  static bool checkIfHex(String? type) {
    if (type == null || type.isEmpty) {
      return false;
    }
    if (type.length == 7 && type[0] == '#') {
      return true;
    } else {
      return false;
    }
  }


  static String errorHandler(e) {
    try {
      return (e.runtimeType == DioException)
          ? ((e as DioException).response?.data["message"] == "Bad request."
              ? (e.response?.data["params"] as Map).values.first[0]
              : e.response?.data["message"])
          : e.toString();
    } catch (s) {
      return (e.runtimeType == DioException)
          ? ((e as DioException).response?.data.toString().substring(
                  (e.response?.data.toString().indexOf("<title>") ?? 0) + 7,
                  e.response?.data.toString().indexOf("</title") ?? 0))
              .toString()
          : e.toString();
    }
  }

  static List<String> extractTextFromControllers(
      List<TextEditingController> controllers) {
    List<String> texts = [];
    for (var controller in controllers) {
      texts.add(controller.text.toLowerCase());
    }
    return texts;
  }

  static Color getStatusColor(String? value) {
    switch (value) {
      case 'pending':
        return Style.pendingDark;
      case 'new':
        return Style.blueColor;
      case 'accepted':
      case 'booked':
        return Style.deepPurple;
      case 'ready':
      case 'progress':
        return Style.revenueColor;
      case 'on_a_way':
        return Style.black;
      case 'unpublished':
        return Style.orange;
      case 'published':
      case 'active':
      case 'true':
      case 'all':
      case 'delivered':
      case 'cash':
      case 'paid':
      case 'approved':
      case 'viewed':
        return Style.green;
      case 'null':
      case 'false':
      case 'cancel':
      case 'inactive':
      case 'canceled':
      case 'note.paid':
        return Style.red;
      default:
        return Style.primary;
    }
  }

  static bool getHourFormat24() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'hour_format') {
        return (setting.value ?? "HH:mm") == "HH:mm";
      }
    }
    return true;
  }

  static double getInitialLatitude() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'location') {
        final String? latString =
            setting.value?.substring(0, setting.value?.indexOf(','));
        if (latString == null) {
          return AppConstants.demoLatitude;
        }
        final double? lat = double.tryParse(latString);
        return lat ?? AppConstants.demoLatitude;
      }
    }
    return AppConstants.demoLatitude;
  }

  static double getInitialLongitude() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'location') {
        final String? latString =
            setting.value?.substring(0, setting.value?.indexOf(','));
        if (latString == null) {
          return AppConstants.demoLongitude;
        }
        final String? lonString = setting.value
            ?.substring((latString.length) + 2, setting.value?.length);
        if (lonString == null) {
          return AppConstants.demoLongitude;
        }
        final double lon = double.parse(lonString);
        return lon;
      }
    }
    return AppConstants.demoLongitude;
  }

  static bool getSubscription() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'subscription') {
        return (setting.value ?? "0") == "1";
      }
    }
    return false;
  }

  static void showAlertDialog({
    required BuildContext context,
    required Widget child,
    double radius = 16,
    Color? backgroundColor,
  }) {
    AlertDialog alert = AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      contentPadding: EdgeInsets.all(16.r),
      iconPadding: EdgeInsets.zero,
      content: child,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
            textDirection: LocalStorage.getLangLtr()
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: alert);
      },
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    required Widget child,
    double radius = 16,
    String? title,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      contentPadding: EdgeInsets.all(16.r),
      iconPadding: EdgeInsets.zero,
      alignment: Alignment.topRight,
      content: SizedBox(
        width: 0.2.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppHelpers.getTranslation(title ?? ""),
                  style: Style.interSemi(size: 18),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Remix.close_fill))
              ],
            ),
            4.verticalSpace,
            child,
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
            textDirection: LocalStorage.getLangLtr()
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: alert);
      },
    );
  }

  static showSnackBar(BuildContext context, String title,
      {bool isIcon = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackBar = SnackBar(
      backgroundColor: Style.white,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.fromLTRB(MediaQuery.sizeOf(context).width - 400.w, 0,
          32, MediaQuery.sizeOf(context).height - 160.h),
      content: Row(
        children: [
          if (isIcon)
            Padding(
              padding: EdgeInsets.only(right: 8.r),
              child: const Icon(
                Remix.checkbox_circle_fill,
                color: Style.primary,
              ),
            ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Style.black,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: AppHelpers.getTranslation(TrKeys.close),
        disabledTextColor: Style.black,
        textColor: Style.black,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String getTranslation(String trKey) {
    final Map<String, dynamic> translations = LocalStorage.getTranslations();
    if (AppConstants.autoTrn) {
      return (translations[trKey] ??
          (trKey.isNotEmpty
              ? trKey.replaceAll(".", " ").replaceAll("_", " ").replaceFirst(
                  trKey.substring(0, 1), trKey.substring(0, 1).toUpperCase())
              : ''));
    } else {
      return translations[trKey] ?? trKey;
    }
  }

  static ExtrasType getExtraTypeByValue(String? value) {
    switch (value) {
      case 'color':
        return ExtrasType.color;
      case 'text':
        return ExtrasType.text;
      case 'image':
        return ExtrasType.image;
      default:
        return ExtrasType.text;
    }
  }

  static get getPriceLabel =>
      "${getTranslation(TrKeys.price)} (${LocalStorage.getSelectedCurrency()?.symbol})*";

  static DateTime getMinTime(String openTime) {
    final int openHour = int.parse(openTime.substring(3, 5)) == 0
        ? int.parse(openTime.substring(0, 2))
        : int.parse(openTime.substring(0, 2)) + 1;
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, openHour);
  }

  static DateTime getMaxTime(String closeTime) {
    final int closeHour = int.parse(closeTime.substring(0, 2));
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, closeHour);
  }

  static String getOrderStatusText(OrderStatus value) {
    switch (value) {
      case OrderStatus.newOrder:
        return "new";
      case OrderStatus.accepted:
        return "accepted";
      case OrderStatus.ready:
        return "ready";
      case OrderStatus.onAWay:
        return "on_a_way";
      case OrderStatus.delivered:
        return "delivered";
      default:
        return "canceled";
    }
  }

  static OrderStatus getOrderStatus(String? value, {bool? isNextStatus}) {
    if (isNextStatus ?? false) {
      switch (value) {
        case 'new':
          return OrderStatus.accepted;
        case 'accepted':
          return OrderStatus.ready;
        case 'ready':
          return OrderStatus.onAWay;
        case 'on_a_way':
          return OrderStatus.delivered;
        default:
          return OrderStatus.canceled;
      }
    } else {
      switch (value) {
        case 'new':
          return OrderStatus.newOrder;
        case 'accepted':
          return OrderStatus.accepted;
        case 'ready':
          return OrderStatus.ready;
        case 'on_a_way':
          return OrderStatus.onAWay;
        case 'delivered':
          return OrderStatus.delivered;
        default:
          return OrderStatus.canceled;
      }
    }
  }

  static String getPinCodeText(int index) {
    switch (index) {
      case 0:
        return "1";
      case 1:
        return "2";
      case 2:
        return "3";
      case 3:
        return "4";
      case 4:
        return "5";
      case 5:
        return "6";
      case 6:
        return "7";
      case 7:
        return "8";
      case 8:
        return "9";
      case 10:
        return "0";
      default:
        return "0";
    }
  }

  static Widget getStatusType(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: text == "new"
            ? Style.blue
            : text == "accept"
                ? Colors.deepPurple
                : text == "ready"
                    ? Style.rate
                    : Style.primary,
      ),
      child: Text(
        getTranslation(text),
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: Style.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static bool getPhoneRequired() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'before_order_phone_required') {
        return (setting.value ?? "0") == "1";
      }
    }
    return false;
  }

  static List<List<Extras>> cartesian(List<List<dynamic>> args) {
    List<List<Extras>> r = [];
    int max = args.length - 1;

    void helper(List<Extras> arr, int i) {
      for (int j = 0, l = args[i].length; j < l; j++) {
        List<Extras> a = List.from(arr);
        a.add(args[i][j]);
        if (i == max) {
          r.add(a);
        } else {
          helper(a, i + 1);
        }
      }
    }

    helper([], 0);
    return r;
  }
}
