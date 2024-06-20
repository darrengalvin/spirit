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

class AwarenessDayCalendarMobile extends StatefulWidget {
  const AwarenessDayCalendarMobile({
    Key? key,
    this.width,
    this.height,
    this.onDateChange,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<void> Function()? onDateChange;

  @override
  _AwarenessDayCalendarMobileState createState() =>
      _AwarenessDayCalendarMobileState();
}

class _AwarenessDayCalendarMobileState
    extends State<AwarenessDayCalendarMobile> {
  DateTime _selectedDate = FFAppState().selectedDate ?? DateTime.now();
  late String _selectedMonth;
  String _selectedAwarenessDayItem = '';
  bool _isLoading = false;
  bool _showNoResultsLabel = false;
  bool _isGenerating = false;
  String _selectedIcon = '';

  @override
  void initState() {
    super.initState();
    _selectedDate =
        DateTime(DateTime.now().year, _selectedDate.month, _selectedDate.day);
    _selectedMonth = DateFormat('MMMM').format(_selectedDate);
    _selectFirstItemForDate(_selectedDate);
  }

  void _updateSelectedMonth(String? newMonth) {
    if (newMonth != null) {
      setState(() {
        _selectedMonth = newMonth;
        _selectedDate = DateTime(
            DateTime.now().year, DateFormat('MMMM').parse(newMonth).month);
        FFAppState().selectedDate = _selectedDate;
        _selectedAwarenessDayItem =
            ''; // Clear selected item when month changes
      });
      _handleDateChange();
    }
  }

  Future<void> _selectItem(DocumentReference docRef) async {
    setState(() {
      FFAppState().selectedAwarenessDay = docRef.id;
      FFAppState().showItem = 'activities';
    });
    _handleDateChange();
  }

  Future<void> _toggleSelected(DocumentReference docRef) async {
    final currentlySelected = FFAppState().selectedAwarenessDay == docRef.id;
    setState(() {
      FFAppState().selectedAwarenessDay = currentlySelected ? '' : docRef.id;
      FFAppState().showItem = 'activities';
    });
    final selectedAwarenessDay = await docRef.get();
    final selectedAwarenessDayData =
        selectedAwarenessDay.data() as Map<String, dynamic>?;

    if (selectedAwarenessDayData != null) {
      final updatedSelectedStatus = !currentlySelected;
      await docRef.update({'selected': updatedSelectedStatus});

      final daySnapshot = await FirebaseFirestore.instance
          .collection('awarenessDays')
          .where('date', isEqualTo: selectedAwarenessDayData['date'])
          .where('companyOwner', isEqualTo: FFAppState().selectedCompanyId)
          .get();
      final batch = FirebaseFirestore.instance.batch();
      for (var doc in daySnapshot.docs) {
        if (doc.id != docRef.id) {
          batch.update(doc.reference, {'selected': false});
        }
      }
      await batch.commit();

      if (selectedAwarenessDayData.containsKey('date')) {
        final selectedDate =
            (selectedAwarenessDayData['date'] as Timestamp).toDate();
        FFAppState().selectedDate = selectedDate;
        setState(() {
          _selectedDate = selectedDate;
          _selectedAwarenessDayItem = selectedAwarenessDayData['item'] ?? '';
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

  Future<void> refreshAwarenessDays(DocumentReference docRef) async {
    final url =
        'https://us-central1-journey-through-play-yez053.cloudfunctions.net/moreAwarenessDays';
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final selectedAwarenessDay = await docRef.get();
    final selectedAwarenessDayData =
        selectedAwarenessDay.data() as Map<String, dynamic>?;

    if (selectedAwarenessDayData == null ||
        !selectedAwarenessDayData.containsKey('date')) {
      print('Error: selectedAwarenessDayData is null or missing date');
      return;
    }

    final selectedDate =
        (selectedAwarenessDayData['date'] as Timestamp).toDate();
    final selectedDateFormatted =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(selectedDate);

    print('Selected date formatted: $selectedDateFormatted');

    final requestBody = {
      'selectedDate': selectedDateFormatted,
      'testflag': 'true',
      'companyId': FFAppState().selectedCompanyId,
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
        print('Awareness days refreshed successfully.');
      } else {
        print(
            'Failed to refresh awareness days. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error refreshing awareness days: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleDateSelection(DateTime date) async {
    setState(() {
      _selectedDate = DateTime(DateTime.now().year, date.month, date.day);
      FFAppState().selectedDate = _selectedDate;
      FFAppState().selectedMonth = DateFormat('MMMM').format(_selectedDate);
    });
    await _selectFirstItemForDate(_selectedDate);
    if (widget.onDateChange != null) {
      await widget.onDateChange!();
    }
    setState(() {}); // Ensure the widget rebuilds to reflect state changes
  }

  void _handleMonthChange(DateTime month) {
    setState(() {
      _selectedDate = DateTime(DateTime.now().year, month.month, 1);
      FFAppState().selectedDate = _selectedDate;
      FFAppState().selectedMonth = DateFormat('MMMM').format(_selectedDate);
    });
  }

  Future<void> _selectFirstItemForDate(DateTime date) async {
    print(
        'Querying for date: $date and companyOwner: ${FFAppState().selectedCompanyId}');
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('awarenessDays')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
          .where('companyOwner', isEqualTo: FFAppState().selectedCompanyId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final firstDoc = snapshot.docs.first;
        await _selectItem(firstDoc.reference);
        setState(() {
          _selectedAwarenessDayItem =
              (firstDoc.data() as Map<String, dynamic>)['item'] ?? '';
        });
      } else {
        print('No awareness days found for the selected date and company.');
      }
    } catch (e) {
      print('Error querying awareness days: $e');
    }
  }

  Future<void> _generateAwarenessDays() async {
    final url =
        'https://us-central1-journey-through-play-yez053.cloudfunctions.net/getAwarenessDays';
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final requestBody = {
      'month': _selectedMonth,
      'companyId': FFAppState().selectedCompanyId,
    };

    print('Selected Month: $_selectedMonth');
    print('Company ID: ${FFAppState().selectedCompanyId}');
    print('Request Body: $requestBody');

    try {
      setState(() {
        _isGenerating = true;
      });

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
        print('Awareness days generated successfully.');
        // Optionally, refresh the list after generation
        await _handleDateSelection(_selectedDate);
      } else {
        print(
            'Failed to generate awareness days. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error generating awareness days: $error');
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date Picker Widget
        DatePicker(
          DateTime(DateTime.now().year, _selectedDate.month, 1),
          initialSelectedDate: _selectedDate,
          selectionColor: Color(0xFF0c4983),
          selectedTextColor: Colors.white,
          daysCount:
              DateTime(DateTime.now().year, _selectedDate.month + 1, 0).day,
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
                _selectedAwarenessDayItem.isNotEmpty
                    ? _selectedAwarenessDayItem
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
              'No new awareness days found.',
              style: TextStyle(color: Colors.red),
            ),
          ),
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('awarenessDays')
                  .where('date',
                      isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                          _selectedDate.day,
                          0,
                          0,
                          0)))
                  .where('date',
                      isLessThan: Timestamp.fromDate(DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                          _selectedDate.day,
                          23,
                          59,
                          59)))
                  .where('companyOwner',
                      isEqualTo: FFAppState().selectedCompanyId)
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

                final awarenessDays = snapshot.data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();

                if (awarenessDays.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'There are no Awareness Days generated for ${DateFormat('MMMM d').format(_selectedDate)}.',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed:
                                _isGenerating ? null : _generateAwarenessDays,
                            child: _isGenerating
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Generating...'),
                                    ],
                                  )
                                : Text('Generate Awareness Days'),
                          ),
                          if (_isGenerating)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Generating awareness days, please wait...',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: awarenessDays.length,
                  itemBuilder: (context, index) {
                    final awarenessDay = awarenessDays[index];
                    final docRef = FirebaseFirestore.instance
                        .collection('awarenessDays')
                        .doc(awarenessDay['documentId']);
                    final isSelected =
                        FFAppState().selectedAwarenessDay == docRef.id;

                    return ListTile(
                      title: Text(
                        awarenessDay['item'] ?? '',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                              letterSpacing: 0,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                      ),
                      trailing: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if ((awarenessDay['linkedActivity']
                                        as List<dynamic>?)
                                    ?.isNotEmpty ??
                                false)
                              _buildIcon(
                                'assets/images/activityicon.png',
                                'activities',
                                () async {
                                  setState(() {
                                    FFAppState().showItem = 'activities';
                                    FFAppState().isSearchingActivities = false;
                                    _selectedIcon = 'activities';
                                    print('Selected activities icon');
                                  });
                                },
                              ),
                            SizedBox(width: 8),
                            if ((awarenessDay['linkedFb'] as List<dynamic>?)
                                    ?.isNotEmpty ??
                                false)
                              _buildIcon(
                                'assets/images/facebook.png',
                                'facebook',
                                () async {
                                  setState(() {
                                    FFAppState().showItem = 'facebook';
                                    _selectedIcon = 'facebook';
                                    print('Selected facebook icon');
                                  });
                                },
                              ),
                            SizedBox(width: 8),
                            if ((awarenessDay['linkedLinkedin']
                                        as List<dynamic>?)
                                    ?.isNotEmpty ??
                                false)
                              _buildIcon(
                                'assets/images/linkedin.png',
                                'linkedin',
                                () async {
                                  setState(() {
                                    FFAppState().showItem = 'linkedin';
                                    _selectedIcon = 'linkedin';
                                    print('Selected linkedin icon');
                                  });
                                },
                              ),
                            SizedBox(width: 8),
                            if ((awarenessDay['linkedX'] as List<dynamic>?)
                                    ?.isNotEmpty ??
                                false)
                              _buildIcon(
                                'assets/images/x_icon.webp',
                                'x',
                                () async {
                                  setState(() {
                                    FFAppState().showItem = 'x';
                                    _selectedIcon = 'x';
                                    print('Selected x icon');
                                  });
                                },
                              ),
                            SizedBox(width: 8),
                            if ((awarenessDay['linkedEmail'] as List<dynamic>?)
                                    ?.isNotEmpty ??
                                false)
                              _buildIcon(
                                'assets/images/teachers_icon.png',
                                'teachers',
                                () async {
                                  setState(() {
                                    FFAppState().showItem = 'teachers';
                                    _selectedIcon = 'teachers';
                                    print('Selected teachers icon');
                                  });
                                },
                              ),
                            SizedBox(width: 8),
                            if ((awarenessDay['linkedBlog'] as List<dynamic>?)
                                    ?.isNotEmpty ??
                                false)
                              _buildIcon(
                                'assets/images/blof.jpeg',
                                'blog',
                                () async {
                                  setState(() {
                                    FFAppState().showItem = 'blog';
                                    _selectedIcon = 'blog';
                                    print('Selected blog icon');
                                  });
                                },
                              ),
                            SizedBox(width: 8),
                            if ((awarenessDay['linkedWhatsapp']
                                        as List<dynamic>?)
                                    ?.isNotEmpty ??
                                false)
                              _buildIcon(
                                'assets/images/whatsapp.jpeg',
                                'whatsapp',
                                () async {
                                  setState(() {
                                    FFAppState().showItem = 'whatsapp';
                                    _selectedIcon = 'whatsapp';
                                    print('Selected whatsapp icon');
                                  });
                                },
                              ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.refresh),
                              color: _isLoading ? Colors.blue : null,
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await refreshAwarenessDays(docRef);
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        _toggleSelected(docRef);
                      },
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

  Widget _buildIcon(String assetPath, String iconType, VoidCallback onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  _selectedIcon == iconType ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
          child: Image.asset(
            assetPath,
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
