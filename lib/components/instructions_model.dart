import '/flutter_flow/flutter_flow_util.dart';
import 'instructions_widget.dart' show InstructionsWidget;
import 'package:flutter/material.dart';

class InstructionsModel extends FlutterFlowModel<InstructionsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}