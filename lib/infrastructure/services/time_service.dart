import 'package:intl/intl.dart';
import 'app_helpers.dart';
import 'tr_keys.dart';

abstract class TimeService {
  TimeService._();

  static final String _timeFormat = AppHelpers.getHourFormat24() ? 'HH:mm' : 'h:mm a';
  static final String? _locale = null;

  static String dateFormatForChat(DateTime? time) {
    if ((DateTime.now().difference(time ?? DateTime.now()).inHours) > 24 &&
        (DateTime.now().difference(time ?? DateTime.now()).inDays) < 7) {
      return DateFormat("EEEE", _locale).format(time ?? DateTime.now());
    }
    if ((DateTime.now().difference(time ?? DateTime.now()).inDays) < 365) {
      return DateFormat("d MMM", _locale).format(time ?? DateTime.now());
    }
    if ((DateTime.now().difference(time ?? DateTime.now()).inDays) > 365) {
      return DateFormat("MMM/d/yyyy", _locale).format(time ?? DateTime.now());
    }
    return DateFormat(_timeFormat, _locale).format(time ?? DateTime.now());
  }

  static DateTime dateFormatYMD(DateTime? time) {
    return DateTime.tryParse(
        DateFormat("yyyy-MM-dd", _locale)
            .format(time ?? DateTime.now())) ??
        DateTime.now();
  }

  static String dateFormatMDYHm(DateTime? time) {
    return DateFormat(
        "d MMM yyyy - $_timeFormat", _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatYMDHm(DateTime? time) {
    return DateFormat("yyyy-MM-dd HH:mm").format(time ?? DateTime.now());
  }  static

  String dateFormatMDHm(DateTime? time) {
    return DateFormat("MMMM dd $_timeFormat").format(time?.toLocal() ?? DateTime.now());
  }

  static String dateFormatDMY(DateTime? time) {
    return DateFormat("d MMM, yyyy", _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatDMM(DateTime? time) {
    return DateFormat("d MMM", _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatEDMY(DateTime? time) {
    return DateFormat("EEEE, d MMM yyyy", _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatDM(DateTime? time) {
    if (DateTime.now().year == time?.year) {
      return DateFormat("d MMMM", _locale)
          .format(time ?? DateTime.now());
    }
    return DateFormat("d MMMM, yyyy", _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatForNotification(DateTime? time) {
    return DateFormat("d MMM, $_timeFormat", _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatDay(DateTime? time) {
    return DateFormat("yyyy-MM-dd").format(time ?? DateTime.now());
  }

  static String dateFormat(DateTime? time) {
    return DateFormat("MMM d,yyyy", _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatForOrder(DateTime? time) {
    return '${DateFormat('dd.MM.yyyy', _locale).format(time ?? DateTime.now())} | ${DateFormat(_timeFormat, _locale).format(time ?? DateTime.now())}';
  }

  static String dateFormatForBooking(List<DateTime?> time) {
    return '${DateFormat('dd.MM.yyyy', _locale).format(time.first ?? DateTime.now())} | ${DateFormat(_timeFormat, _locale).format(time.first ?? DateTime.now())}-${DateFormat(_timeFormat, _locale).format(time.last ?? DateTime.now())}';
  }

  static String timeFormatForBooking(List<DateTime?> time) {
    return '${DateFormat(_timeFormat, _locale).format(time.first ?? DateTime.now())}-${DateFormat(_timeFormat, _locale).format(time.last ?? DateTime.now())}';
  }

  static String dateFormatMulti(List<DateTime?> time) {
    String response = '';
    if (time.isEmpty) {
      response += AppHelpers.getTranslation(TrKeys.selectTime);

      return response;
    }
    for (int i = 0; i < time.length; i++) {
      if (time[i] != null) {
        response += DateFormat("d MMM yyyy", _locale)
            .format(time[i]!);
        if (i == 0 && time.length > 1) {
          response += '  -  ';
        }
      }
    }
    return response;
  }

  static String timeFormatMulti(List<DateTime?> time) {
    String response = '';
    if (time.isEmpty) {
      response += AppHelpers.getTranslation(TrKeys.selectTime);

      return response;
    }
    for (int i = 0; i < time.length; i++) {
      if (time[i] != null) {
        response += DateFormat(_timeFormat, _locale)
            .format(time[i]!);
        if (i == 0 && time.length > 1) {
          response += ' - ';
        }
      }
    }
    return response;
  }

  static String timeFormat(DateTime? time) {
    return DateFormat(_timeFormat, _locale)
        .format(time ?? DateTime.now());
  }

  static String dateFormatFilter(
      {required DateTime? start, required DateTime? end}) {
    return '${DateFormat("MMM d, yyyy",_locale).format(start ?? DateTime.now())} - ${DateFormat("MMM d,yyyy",_locale).format(end ?? DateTime.now())}';
  }

  static String timeFormat24(DateTime? time) {
    return DateFormat("HH:mm", _locale)
        .format(time ?? DateTime.now());
  }

  static String timeFormatTime(String? time) {
    if (time == null) {
      return '';
    }
    return DateFormat(_timeFormat).format(
        DateTime.now().add(Duration(days: 1)).copyWith(
            hour: int.tryParse(time.substring(0, time.indexOf(':'))) ?? 0,
            minute:
            int.tryParse(time.substring(time.indexOf(':')+1, time.length)) ??
                0));
  }
}
