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

class BlogTemplate extends StatefulWidget {
  const BlogTemplate({
    super.key,
    this.width,
    this.height,
    this.title,
    this.author,
    this.timestamp,
    this.content,
    this.imageUrl,
  });

  final double? width;
  final double? height;
  final String? title;
  final String? author;
  final String? timestamp;
  final String? content;
  final String? imageUrl;

  @override
  State<BlogTemplate> createState() => _BlogTemplateState();
}

class _BlogTemplateState extends State<BlogTemplate> {
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
          // Title
          Text(
            widget.title ?? 'Title not provided.',
            style: FlutterFlowTheme.of(context).title1.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 10),
          // Author and Timestamp
          Row(
            children: [
              Text(
                'By ${widget.author ?? 'Author'}',
                style: FlutterFlowTheme.of(context).bodyText2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.grey,
                      fontSize: 12,
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
          // Content
          Text(
            widget.content ??
                'This is an example of a blog post content. It can include text, images, and links.',
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 14,
                ),
          ),
          SizedBox(height: 10),
          // Image
          if (widget.imageUrl != null)
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
