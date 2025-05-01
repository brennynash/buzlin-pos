import 'package:flutter/material.dart';
import '../../domain/models/data/booking_data.dart';
import 'enums.dart';

typedef DetectorBuilder = Widget Function({
  required DateTime date,
  required double height,
  required double width,
  required double heightPerMinute,
  required MinuteSlotSize minuteSlotSize,
});

typedef CalendarPageChangeCallBack = void Function(DateTime date, int page);

typedef CellTapCallback = void Function(
    List<BookingData> events, DateTime date);

typedef EventFilter = List<BookingData> Function(
    DateTime date, List<BookingData> events);

