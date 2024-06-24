import '/components/j_t_p_login_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
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
