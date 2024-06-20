import '/components/j_t_p_login_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'j_t_p_login_widget.dart' show JTPLoginWidget;
import 'package:flutter/material.dart';

class JTPLoginModel extends FlutterFlowModel<JTPLoginWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for JTPLoginComponent component.
  late JTPLoginComponentModel jTPLoginComponentModel;

  @override
  void initState(BuildContext context) {
    jTPLoginComponentModel =
        createModel(context, () => JTPLoginComponentModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    jTPLoginComponentModel.dispose();
  }
}
