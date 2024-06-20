import '/flutter_flow/flutter_flow_util.dart';
import 'form_a_p_i_call_widget.dart' show FormAPICallWidget;
import 'package:flutter/material.dart';

class FormAPICallModel extends FlutterFlowModel<FormAPICallWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for nameDaily widget.
  FocusNode? nameDailyFocusNode;
  TextEditingController? nameDailyTextController;
  String? Function(BuildContext, String?)? nameDailyTextControllerValidator;
  // State field(s) for dateawareness widget.
  FocusNode? dateawarenessFocusNode;
  TextEditingController? dateawarenessTextController;
  String? Function(BuildContext, String?)? dateawarenessTextControllerValidator;
  // State field(s) for refWareness widget.
  FocusNode? refWarenessFocusNode;
  TextEditingController? refWarenessTextController;
  String? Function(BuildContext, String?)? refWarenessTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameDailyFocusNode?.dispose();
    nameDailyTextController?.dispose();

    dateawarenessFocusNode?.dispose();
    dateawarenessTextController?.dispose();

    refWarenessFocusNode?.dispose();
    refWarenessTextController?.dispose();
  }
}
