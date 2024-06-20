import '/flutter_flow/flutter_flow_util.dart';
import 'refresh_app_state_widget.dart' show RefreshAppStateWidget;
import 'package:flutter/material.dart';

class RefreshAppStateModel extends FlutterFlowModel<RefreshAppStateWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
