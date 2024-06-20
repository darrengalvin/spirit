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

class TwitterTemplate extends StatefulWidget {
  const TwitterTemplate({
    super.key,
    this.width,
    this.height,
    this.timestamp,
    this.content,
  });

  final double? width;
  final double? height;
  final String? timestamp;
  final String? content;

  @override
  State<TwitterTemplate> createState() => _TwitterTemplateState();
}

class _TwitterTemplateState extends State<TwitterTemplate> {
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
          // Profile Information
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage('https://example.com/default-profile-pic.jpg'),
                radius: 20,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GAP Club',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.timestamp ?? '',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          // Post Content
          Text(
            widget.content ?? '',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
