// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart'; // Import the intl package for DateFormat

import 'package:date_picker_timeline/date_picker_timeline.dart'; // Import the package

class DatePickerTimelineWidget extends StatefulWidget {
  const DatePickerTimelineWidget({
    Key? key,
    this.width,
    this.height,
    this.maxWidth,
    this.onDateChange,
    this.initialDate,
    this.selectedDate,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? maxWidth;
  final Future<void> Function()? onDateChange;
  final DateTime? initialDate;
  final DateTime? selectedDate;

  @override
  _DatePickerTimelineWidgetState createState() =>
      _DatePickerTimelineWidgetState();
}

class _DatePickerTimelineWidgetState extends State<DatePickerTimelineWidget> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate =
        _truncateMilliseconds(widget.selectedDate ?? DateTime.now());
    _currentMonth = _truncateMilliseconds(widget.initialDate ?? DateTime.now());
  }

  DateTime _truncateMilliseconds(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
    );
  }

  Future<void> _handleDateChange(DateTime date) async {
    setState(() {
      _selectedDate = _truncateMilliseconds(date);
      FFAppState().selectedDate = _truncateMilliseconds(date);
      FFAppState().selectedMonth =
          DateFormat('MMMM').format(date); // Save selected month to FFAppState
    });
    if (widget.onDateChange != null) {
      await widget.onDateChange!();
    }
  }

  void _handleMonthChange(DateTime month) {
    setState(() {
      _currentMonth = _truncateMilliseconds(month);
      _selectedDate = DateTime(month.year, month.month, 1);
      FFAppState().selectedDate = _truncateMilliseconds(_selectedDate);
      FFAppState().selectedMonth = DateFormat('MMMM')
          .format(_selectedDate); // Save selected month to FFAppState
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> months = [
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
    List<int> years =
        List<int>.generate(20, (index) => DateTime.now().year - 10 + index);

    return Center(
      child: Container(
        width: widget.width,
        height: widget.height,
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth ?? double.infinity,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Align components
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(26, 0, 0, 0),
                  child: Text(
                    FFAppState().selectedDate != null
                        ? dateTimeFormat('MMMMEEEEd', FFAppState().selectedDate)
                        : "No date selected",
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 24,
                          letterSpacing: 0,
                        ),
                  ),
                ),
                Row(
                  children: [
                    DropdownButton<int>(
                      value: _currentMonth.year,
                      items: years.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newYear) {
                        if (newYear != null) {
                          _handleMonthChange(
                              DateTime(newYear, _currentMonth.month));
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: months[_currentMonth.month - 1],
                      items: months.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        );
                      }).toList(),
                      onChanged: (String? newMonth) {
                        if (newMonth != null) {
                          int newMonthIndex = months.indexOf(newMonth) + 1;
                          _handleMonthChange(
                              DateTime(_currentMonth.year, newMonthIndex));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: DatePicker(
                DateTime(_currentMonth.year, _currentMonth.month, 1),
                initialSelectedDate: _selectedDate,
                selectionColor: Color(0xFF0c4983), // Updated color
                selectedTextColor: Colors.white,
                onDateChange: (date) async {
                  await _handleDateChange(date);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
