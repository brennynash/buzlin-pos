import 'package:remixicon_updated/remixicon_updated.dart';

import '../services/tr_keys.dart';

abstract class DropDownValues {
  DropDownValues._();

  static const int hoursADay = 24;
  static const int minutesADay = 1440;

  static List<String> timeOptionsList = [
    TrKeys.oneDay,
    TrKeys.threeDays,
    TrKeys.sevenDays,
    TrKeys.fourteenDays,
    TrKeys.oneMonth,
    TrKeys.twoMonth,
    TrKeys.threeMonth,
    TrKeys.fourMonth,
    TrKeys.fiveMonth,
    TrKeys.sixMonth,
    TrKeys.eightMonth,
    TrKeys.eighteenMonth,
    TrKeys.oneYear,
    TrKeys.twoYears,
    TrKeys.fiveYears,
  ];

  static List<String> answerType = [
    "short_answer",
    "long_answer",
    "single_answer",
    "multiple_choice",
    "drop_down",
    "yes_or_no",
    "description_text",
  ];

  static List<String> sessionsList = [TrKeys.limited, TrKeys.unlimited];

  static final List<String> weekTitles = ["M", "T", "W", "T", "F", "S", "S"];

  static List<String> deliveryTypeList = [TrKeys.inHouse, TrKeys.ownSeller];
  static List<String> deliveryTimeTypeList = [
    "minute",
    "hour",
    "day",
    "week",
    "month"
  ];
  static List<String> serviceTypeList = [
    TrKeys.online,
    TrKeys.offlineIn,
    TrKeys.offlineOut,
  ];
  static List<String> genderList = [
    TrKeys.male,
    TrKeys.female,
    TrKeys.all,
  ];
  static List<String> gender = [
    TrKeys.male,
    TrKeys.female,
  ];
  static List<String> repeatsList = [
    'dont_repeat',
    'day',
    'week',
    'month',
    'custom',
  ];
  static List<String> endTypeList = [
    'never',
    'date',
    'after',
  ];
  static List<String> customRepeatType = ["day", "week", "month"];
  static const socialIcon = {
    "facebook": Remix.facebook_fill,
    "instagram": Remix.instagram_fill,
    "telegram": Remix.telegram_fill,
    "youtube": Remix.youtube_fill,
    "linkedin": Remix.linkedin_fill,
    "snapchat": Remix.snapchat_fill,
    "wechat": Remix.wechat_fill,
    "whatsapp": Remix.whatsapp_fill,
    "twitch": Remix.twitch_fill,
    "discord": Remix.discord_fill,
    "pinterest": Remix.pinterest_fill,
    "steam": Remix.steam_fill,
    "spotify": Remix.spotify_fill,
    "reddit": Remix.reddit_fill,
    "skype": Remix.skype_fill,
    "twitter": Remix.twitter_fill,
  };
}
