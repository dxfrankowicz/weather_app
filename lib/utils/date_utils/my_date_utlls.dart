import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyDateUtils {
  static final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
  static final DateFormat _dayFormat = new DateFormat("dd");
  static final DateFormat _firstDayFormat = new DateFormat("MMM dd");
  static final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy");
  static final DateFormat _apiDayFormat = new DateFormat("yyyy-MM-dd");

  static String formatMonth(DateTime d) => _monthFormat.format(d);
  static String formatDay(DateTime d) => _dayFormat.format(d);
  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);

  static List<DateTime> daysInMonthFromDateTime(DateTime month) {
    var first = firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(new Duration(days: daysBefore));
    var last = MyDateUtils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;
    var lastToDisplay = last.add(new Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return new DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = new DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday - 1;
    return day.subtract(new Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = new DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = day.weekday - 1;
    return day.add(new Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? new DateTime(month.year, month.month + 1, 1)
        : new DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(new Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(new Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = new DateTime.utc(a.year, a.month, a.day);
    b = new DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday - min.weekday >= 0;
    return result;
  }

  static String getDateWeekdayName(BuildContext context, DateTime d) {
    initializeDateFormatting("pl_PL");
    var formatter =
    new DateFormat('E', Localizations.localeOf(context).toString());
    return formatter.format(d);
  }

  static String getFullDateWeekdayName(BuildContext context, DateTime d) {
    initializeDateFormatting("pl_PL");
    var formatter =
    new DateFormat('EEEE', Localizations.localeOf(context).toString());
    return formatter.format(d);
  }

  static String formatDate(DateTime d) {
    var formatter = new DateFormat('dd.MM.yyyy');
    return formatter.format(d);
  }

  static String formatDateWithName(BuildContext context, DateTime d) {
    var locale = Localizations.localeOf(context).toString();
    initializeDateFormatting(locale);

    var formatter = new DateFormat(
        'dd.MM.yyyy (EEEEE)', Localizations.localeOf(context).toString());
    return formatter.format(d);
  }

  static String formatApiDate(DateTime d) {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(d);
  }

  static DateTime getDateWithoutTime(DateTime d) {
    return DateTime.parse(formatApiDate(d));
  }

  static String formatHour(DateTime d) {
    if (d == null) return "";
    var formatter = new DateFormat('HH:mm');
    return formatter.format(d);
  }

  static String getShortMonthName(BuildContext context, int m) {
    var locale = Localizations.localeOf(context).toString();
    initializeDateFormatting(locale);
    var formatter = new DateFormat('M');
    var formatter2 = new DateFormat('MMM', locale);

    var dateTime = formatter.parse(m.toString());

    return formatter2.format(dateTime);
  }

  static String getShortMonthNameWithYear(
      BuildContext context, DateTime dateTime) {
    var locale = Localizations.localeOf(context).toString();
    initializeDateFormatting(locale);
    DateFormat monthFormat = new DateFormat("LLL yyyy", locale);

    return monthFormat.format(dateTime);
  }

  static String getShortMonthNameWithShortYear(
      BuildContext context, DateTime dateTime) {
    var locale = Localizations.localeOf(context).toString();
    initializeDateFormatting(locale);
    DateFormat monthFormat = new DateFormat("LLL yy", locale);

    return monthFormat.format(dateTime);
  }

  static String getFullMonthName(BuildContext context, int m) {
    var locale = Localizations.localeOf(context).toString();
    initializeDateFormatting(locale);
    var formatter = new DateFormat('M');
    var formatter2 = new DateFormat('MMMM', locale);

    var dateTime = formatter.parse(m.toString());

    return formatter2.format(dateTime);
  }

  static String getFullMonthNameFromDate(BuildContext context, DateTime date) {
    var locale = Localizations.localeOf(context).toString();
    initializeDateFormatting(locale);
    DateFormat monthFormat = new DateFormat("LLLL yyyy", locale);

    return monthFormat.format(date);
  }

  static DateTime getLastDayOfMonth(int selectedYear, int selectedMonth) {
    DateTime lastDayOfMonth = new DateTime(selectedYear, selectedMonth + 1, 0);
    return lastDayOfMonth;
  }

  static String formatDateTime(DateTime d) {
    if (d == null) return "";

    var formatter = new DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(d);
  }
}
