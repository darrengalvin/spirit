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

class FacebookTemplate extends StatefulWidget {
  const FacebookTemplate({
    super.key,
    this.width,
    this.height,
    this.profilePicUrl,
    this.username,
    this.timestamp,
    this.content,
    this.mediaUrl,
  });

  final double? width;
  final double? height;
  final String? profilePicUrl;
  final String? username;
  final String? timestamp;
  final String? content;
  final String? mediaUrl;

  @override
  State<FacebookTemplate> createState() => _FacebookTemplateState();
}

class _FacebookTemplateState extends State<FacebookTemplate> {
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
          // Post Content
          Text(
            widget.content ??
                'This is an example of a Facebook post content. It can include text, hashtags, and mentions.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          // Media
          if (widget.mediaUrl != null)
            Container(
              width: double
                  .infinity, // Ensure the image fills the width of the container
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(widget.mediaUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(height: 10),
          // Engagement Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('Like'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.comment, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('Comment'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.share, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('Share'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
