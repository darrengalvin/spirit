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

import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';

class LinkedInTemplate extends StatefulWidget {
  const LinkedInTemplate({
    super.key,
    this.width,
    this.height,
    this.profilePicUrl,
    this.username,
    this.timestamp,
    this.headline,
    this.linkDescription,
    this.mainText,
    this.mediaUrl,
  });

  final double? width;
  final double? height;
  final String? profilePicUrl;
  final String? username;
  final String? timestamp;
  final String? headline;
  final String? linkDescription;
  final String? mainText;
  final String? mediaUrl;

  @override
  State<LinkedInTemplate> createState() => _LinkedInTemplateState();
}

class _LinkedInTemplateState extends State<LinkedInTemplate> {
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
                backgroundImage: NetworkImage(widget.profilePicUrl ??
                    'https://example.com/default-profile-pic.jpg'),
                radius: 20,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username ?? 'Username',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.timestamp ?? 'Timestamp',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          // Headline
          Text(
            widget.headline ?? 'Headline not provided.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Main Text
          if (widget.mainText != null)
            Text(
              widget.mainText!,
              style: TextStyle(fontSize: 14),
            ),
          SizedBox(height: 10),
          // Media
          if (widget.mediaUrl != null)
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.mediaUrl!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
