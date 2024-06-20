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
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class FacebookAuthButton extends StatefulWidget {
  const FacebookAuthButton({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<FacebookAuthButton> createState() => _FacebookAuthButtonState();
}

class _FacebookAuthButtonState extends State<FacebookAuthButton> {
  final String authUrl =
      'https://www.facebook.com/v10.0/dialog/oauth?client_id=436397162480085&redirect_uri=https://journey-through-play-yez053.web.app/socialSetup&state={state-param}';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunch(authUrl)) {
            await launch(authUrl);
          } else {
            throw 'Could not launch $authUrl';
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: FlutterFlowTheme.of(context).subtitle2Family,
                useGoogleFonts: GoogleFonts.asMap()
                    .containsKey(FlutterFlowTheme.of(context).subtitle2Family),
              ),
        ),
        child: Text('Connect with Facebook'),
      ),
    );
  }
}
