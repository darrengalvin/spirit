import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? checkMonth(DateTime? theIncomingDate) {
  if (theIncomingDate == null) {
    return null;
  }

  // List of month names
  final monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Extract the month index from the date (1-based index)
  final monthIndex = theIncomingDate.month - 1;

  // Return the month name
  return monthNames[monthIndex];
}

int? getDayOfMonth(DateTime? theIncomingDate) {
  if (theIncomingDate == null) {
    return null;
  }

  // Extract the day of the month from the date
  final dayOfMonth = theIncomingDate.day;

  // Return the day of the month
  return dayOfMonth;
}

DateTime? getMonthOnly(DateTime? theIncomingDate) {
  if (theIncomingDate == null) {
    return null;
  }

  // Extract the month from the date
  final month = theIncomingDate.month;

  // Use a default year, e.g., 2000, and a default day, e.g., 1
  const int defaultYear = 2000;
  const int defaultDay = 1;

  // Construct and return the new DateTime object with the default year and day
  return DateTime(defaultYear, month, defaultDay);
}

DateTime? getDayAndMonth(DateTime? theIncomingDate) {
  if (theIncomingDate == null) {
    return null;
  }

  // Extract the day, month, hour, minute, and second from the date
  final dayOfMonth = theIncomingDate.day;
  final month = theIncomingDate.month;
  final hour = theIncomingDate.hour;
  final minute = theIncomingDate.minute;
  final second = theIncomingDate.second;

  // Use a default year, e.g., 2000
  const int defaultYear = 2000;

  // Construct and return the new DateTime object with the default year and extracted time components, ignoring milliseconds
  return DateTime(defaultYear, month, dayOfMonth, hour, minute, second);
}
