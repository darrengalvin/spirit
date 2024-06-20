import '/flutter_flow/flutter_flow_util.dart';
import 'social_setup_widget.dart' show SocialSetupWidget;
import 'package:flutter/material.dart';

class SocialSetupModel extends FlutterFlowModel<SocialSetupWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
