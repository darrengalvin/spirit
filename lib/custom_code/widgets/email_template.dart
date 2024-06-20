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

class EmailTemplate extends StatefulWidget {
  const EmailTemplate({
    super.key,
    this.width,
    this.height,
    this.sender,
    this.recipient,
    this.timestamp,
    this.subject,
    this.introduction,
    this.activityDetails,
    this.closingRemark,
  });

  final double? width;
  final double? height;
  final String? sender;
  final String? recipient;
  final String? timestamp;
  final String? subject;
  final String? introduction;
  final String? activityDetails;
  final String? closingRemark;

  @override
  State<EmailTemplate> createState() => _EmailTemplateState();
}

class _EmailTemplateState extends State<EmailTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Header
          Text(
            'From: ${widget.sender ?? 'Sender'}',
            style: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.grey,
                  fontSize: 12,
                ),
          ),
          Text(
            'To: ${widget.recipient ?? 'Recipient'}',
            style: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.grey,
                  fontSize: 12,
                ),
          ),
          Text(
            'Date: ${widget.timestamp ?? 'Timestamp'}',
            style: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.grey,
                  fontSize: 12,
                ),
          ),
          SizedBox(height: 10),
          // Subject
          Text(
            widget.subject ?? 'Subject not provided.',
            style: FlutterFlowTheme.of(context).title2.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 10),
          // Introduction
          Text(
            widget.introduction ?? 'Introduction not provided.',
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 14,
                ),
          ),
          SizedBox(height: 10),
          // Activity Details
          Text(
            widget.activityDetails ?? 'Activity details not provided.',
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 14,
                ),
          ),
          SizedBox(height: 10),
          // Closing Remark
          Text(
            widget.closingRemark ?? 'Closing remark not provided.',
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
