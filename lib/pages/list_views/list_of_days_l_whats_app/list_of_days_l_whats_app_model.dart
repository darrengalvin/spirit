import '/flutter_flow/flutter_flow_util.dart';
import 'list_of_days_l_whats_app_widget.dart' show ListOfDaysLWhatsAppWidget;
import 'package:flutter/material.dart';

class ListOfDaysLWhatsAppModel
    extends FlutterFlowModel<ListOfDaysLWhatsAppWidget> {
  ///  Local state fields for this component.

  String showItem = 'activities';

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
