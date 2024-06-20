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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:url_launcher/url_launcher.dart'; // Import this package

class NewsDayCalendar extends StatefulWidget {
  const NewsDayCalendar({
    Key? key,
    this.width,
    this.height,
    this.onDateChange,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<void> Function()? onDateChange;

  @override
  _NewsDayCalendarState createState() => _NewsDayCalendarState();
}

class _NewsDayCalendarState extends State<NewsDayCalendar> {
  DateTime _selectedDate = FFAppState().selectedDate ?? DateTime.now();
  late String _selectedMonth;
  String _selectedNewsDayItem = '';
  bool _isLoading = false;
  bool _showNoResultsLabel = false;
  bool _showAllMonth = false;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateFormat('MMMM').format(_selectedDate);
    _selectFirstItemForDate(_selectedDate);
  }

  void _updateSelectedMonth(String? newMonth) {
    if (newMonth != null) {
      setState(() {
        _selectedMonth = newMonth;
        _selectedDate = DateTime(
            _selectedDate.year, DateFormat('MMMM').parse(newMonth).month);
        FFAppState().selectedDate = _selectedDate;
        _selectedNewsDayItem = ''; // Clear selected item when month changes
        _showAllMonth = false;
      });
      _handleDateChange();
    }
  }

  Future<void> _selectItem(DocumentReference docRef) async {
    setState(() {
      FFAppState().selectedNewsDay = docRef.id;
      FFAppState().showItem = 'activities';
    });
    _handleDateChange();
  }

  Future<void> _toggleSelected(DocumentReference docRef) async {
    final currentlySelected = FFAppState().selectedNewsDay == docRef.id;
    setState(() {
      FFAppState().selectedNewsDay = currentlySelected ? '' : docRef.id;
      FFAppState().showItem = 'activities';
    });
    final selectedNewsDay = await docRef.get();
    final selectedNewsDayData = selectedNewsDay.data() as Map<String, dynamic>?;

    if (selectedNewsDayData != null) {
      final updatedSelectedStatus = !currentlySelected;
      await docRef.update({'selected': updatedSelectedStatus});

      final daySnapshot = await FirebaseFirestore.instance
          .collection('newsDays')
          .where('date', isEqualTo: selectedNewsDayData['date'])
          .get();
      final batch = FirebaseFirestore.instance.batch();
      for (var doc in daySnapshot.docs) {
        if (doc.id != docRef.id) {
          batch.update(doc.reference, {'selected': false});
        }
      }
      await batch.commit();

      if (selectedNewsDayData.containsKey('date')) {
        final selectedDate =
            (selectedNewsDayData['date'] as Timestamp).toDate();
        FFAppState().selectedDate = selectedDate;
        setState(() {
          _selectedDate = selectedDate;
          _selectedNewsDayItem = selectedNewsDayData['item'] ?? '';
        });
        _handleDateChange();
      }
    }
  }

  Future<void> _handleDateChange() async {
    if (widget.onDateChange != null) {
      await widget.onDateChange!();
    }
    setState(() {}); // Ensure the widget rebuilds to reflect state changes
  }

  Future<void> refreshNewsDays(DocumentReference docRef) async {
    final url =
        'https://us-central1-journey-through-play-yez053.cloudfunctions.net/moreNewsDays';
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final selectedNewsDay = await docRef.get();
    final selectedNewsDayData = selectedNewsDay.data() as Map<String, dynamic>?;

    if (selectedNewsDayData == null ||
        !selectedNewsDayData.containsKey('date')) {
      print('Error: selectedNewsDayData is null or missing date');
      return;
    }

    final selectedDate = (selectedNewsDayData['date'] as Timestamp).toDate();
    final selectedDateFormatted =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(selectedDate);

    print('Selected date formatted: $selectedDateFormatted');

    final requestBody = {
      'selectedDate': selectedDateFormatted,
      'testflag': 'true'
    };

    print('Request body: ${json.encode(requestBody)}');
    print('Token: $token');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['status'] == 'no data') {
          setState(() {
            _showNoResultsLabel = true;
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _showNoResultsLabel = false;
            });
          });
        }
        print('News days refreshed successfully.');
      } else {
        print(
            'Failed to refresh news days. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error refreshing news days: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleDateSelection(DateTime date) async {
    setState(() {
      _selectedDate = date;
      FFAppState().selectedDate = date;
      FFAppState().selectedMonth = DateFormat('MMMM').format(date);
    });
    await _selectFirstItemForDate(date);
    if (widget.onDateChange != null) {
      await widget.onDateChange!();
    }
    setState(() {}); // Ensure the widget rebuilds to reflect state changes
  }

  void _handleMonthChange(DateTime month) {
    setState(() {
      _selectedDate = DateTime(month.year, month.month, 1);
      FFAppState().selectedDate = _selectedDate;
      FFAppState().selectedMonth = DateFormat('MMMM').format(_selectedDate);
      _showAllMonth = false;
    });
  }

  Future<void> _selectFirstItemForDate(DateTime date) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('newsDays')
        .where('date', isEqualTo: Timestamp.fromDate(date))
        .get();

    if (snapshot.docs.isNotEmpty) {
      final firstDoc = snapshot.docs.first;
      await _selectItem(firstDoc.reference);
      setState(() {
        _selectedNewsDayItem =
            (firstDoc.data() as Map<String, dynamic>)['item'] ?? '';
      });
    } else {
      setState(() {
        _selectedNewsDayItem = ''; // Handle null entries gracefully
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime(_selectedDate.year, _selectedDate.month, 1),
          initialSelectedDate: _selectedDate,
          selectionColor: Color(0xFF0c4983),
          selectedTextColor: Colors.white,
          daysCount:
              DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day,
          onDateChange: (date) async {
            await _handleDateSelection(date);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
              child: Text(
                _selectedNewsDayItem.isNotEmpty
                    ? _selectedNewsDayItem
                    : 'No event found for ${DateFormat('MMMM d').format(_selectedDate)}',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 22,
                      letterSpacing: 0,
                    ),
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat('MMMM yyyy').format(_selectedDate),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedMonth,
                  items: [
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
                    'December',
                  ].map((month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: _updateSelectedMonth,
                ),
              ],
            ),
          ],
        ),
        if (_showNoResultsLabel)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No new news days found.',
              style: TextStyle(color: Colors.red),
            ),
          ),
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('newsDays')
                  .where('date',
                      isGreaterThanOrEqualTo: Timestamp.fromDate(
                          DateTime(_selectedDate.year, _selectedDate.month, 1)))
                  .where('date',
                      isLessThan: Timestamp.fromDate(DateTime(
                          _selectedDate.year, _selectedDate.month + 1, 1)))
                  .orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final newsDays = snapshot.data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();

                if (newsDays.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'There are no news days available for $_selectedMonth.',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'To populate the data, you can trigger the getNewsDays script by making a POST request to:',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          SizedBox(height: 8),
                          SelectableText(
                            'https://us-central1-journey-through-play-yez053.cloudfunctions.net/getNewsDays',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Provide the following JSON payload in the request body:',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                          ),
                          SizedBox(height: 8),
                          SelectableText(
                            '{ "month": "$_selectedMonth" }',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final newsDaysByDay = <int, List<Map<String, dynamic>>>{};
                for (var newsDay in newsDays) {
                  final date = (newsDay['date'] as Timestamp?)?.toDate();
                  final day = date?.day ?? 1; // Handle null dates gracefully
                  if (!newsDaysByDay.containsKey(day)) {
                    newsDaysByDay[day] = [];
                  }
                  newsDaysByDay[day]!.add(newsDay);
                }

                final sortedKeys = newsDaysByDay.keys.toList()..sort();
                if (_selectedDate.day > 1 && !_showAllMonth) {
                  sortedKeys.removeWhere((day) => day < _selectedDate.day);
                }

                return ListView.builder(
                  itemCount: sortedKeys.length,
                  itemBuilder: (context, index) {
                    final dayOfMonth = sortedKeys[index];
                    final newsDaysOnDay = newsDaysByDay[dayOfMonth]!;

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    dayOfMonth.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 30,
                                          letterSpacing: 0,
                                        ),
                                  ),
                                  Spacer(),
                                  if (_isLoading)
                                    CircularProgressIndicator()
                                  else
                                    IconButton(
                                      icon: Icon(Icons.refresh),
                                      onPressed: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await refreshNewsDays(FirebaseFirestore
                                            .instance
                                            .collection('newsDays')
                                            .doc(newsDaysOnDay[0]
                                                ['documentId']));
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      },
                                    ),
                                ],
                              ),
                              SizedBox(height: 8),
                              ...newsDaysOnDay.map((newsDay) {
                                final docRef = FirebaseFirestore.instance
                                    .collection('newsDays')
                                    .doc(newsDay['documentId']);
                                final isSelected =
                                    FFAppState().selectedNewsDay == docRef.id;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedDate = (newsDay['date']
                                                  as Timestamp?)
                                              ?.toDate() ??
                                          _selectedDate; // Handle null date gracefully
                                      FFAppState().selectedDate = _selectedDate;
                                      _selectedNewsDayItem =
                                          newsDay['item'] ?? '';
                                    });
                                    _toggleSelected(docRef);
                                    setState(() {}); // Ensure UI updates
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 4.0),
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Color(0xFF3993A0).withOpacity(0.2)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            newsDay['item'] ?? '',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            if ((newsDay['linkedActivity']
                                                        as List<dynamic>?)
                                                    ?.isNotEmpty ??
                                                false)
                                              Image.asset(
                                                'assets/images/activityicon.png',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(width: 8),
                                            if ((newsDay['linkedFb']
                                                        as List<dynamic>?)
                                                    ?.isNotEmpty ??
                                                false)
                                              Image.asset(
                                                'assets/images/facebook.png',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(width: 8),
                                            if ((newsDay['linkedLinkedin']
                                                        as List<dynamic>?)
                                                    ?.isNotEmpty ??
                                                false)
                                              Image.asset(
                                                'assets/images/linkedin.png',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(width: 8),
                                            if ((newsDay['linkedX']
                                                        as List<dynamic>?)
                                                    ?.isNotEmpty ??
                                                false)
                                              Image.asset(
                                                'assets/images/x_icon.webp',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(width: 8),
                                            if ((newsDay['linkedEmail']
                                                        as List<dynamic>?)
                                                    ?.isNotEmpty ??
                                                false)
                                              Image.asset(
                                                'assets/images/teachers_icon.png',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(width: 8),
                                            if ((newsDay['linkedBlog']
                                                        as List<dynamic>?)
                                                    ?.isNotEmpty ??
                                                false)
                                              Image.asset(
                                                'assets/images/blof.jpeg',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(width: 8),
                                            if ((newsDay['linkedWhatsapp']
                                                        as List<dynamic>?)
                                                    ?.isNotEmpty ??
                                                false)
                                              Image.asset(
                                                'assets/images/whatsapp.jpeg',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(width: 8),
                                            if (newsDay['source'] != null)
                                              Tooltip(
                                                message: newsDay['source'] ??
                                                    'No source available',
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    final url =
                                                        newsDay['source'];
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.link,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
