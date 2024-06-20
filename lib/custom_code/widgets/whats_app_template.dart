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

class WhatsAppTemplate extends StatefulWidget {
  const WhatsAppTemplate({
    super.key,
    this.width,
    this.height,
    this.sender,
    this.message,
    this.timestamp,
  });

  final double? width;
  final double? height;
  final String? sender;
  final String? message;
  final String? timestamp;

  @override
  State<WhatsAppTemplate> createState() => _WhatsAppTemplateState();
}

class _WhatsAppTemplateState extends State<WhatsAppTemplate> {
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
          // Sender and Timestamp
          Row(
            children: [
              Text(
                widget.sender ?? 'Sender',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Spacer(),
              Text(
                widget.timestamp ?? 'Timestamp',
                style: FlutterFlowTheme.of(context).bodyText2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.grey,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Message
          Text(
            widget.message ??
                'This is an example of a WhatsApp message content. It can include text, emojis, and links.',
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
