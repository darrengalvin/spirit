import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_of_days_l_email_widget.dart' show ListOfDaysLEmailWidget;
import 'package:flutter/material.dart';

class ListOfDaysLEmailModel extends FlutterFlowModel<ListOfDaysLEmailWidget> {
  ///  Local state fields for this component.

  String showItem = 'activities';

  TeachersStruct? teachersList;
  void updateTeachersListStruct(Function(TeachersStruct) updateFn) {
    updateFn(teachersList ??= TeachersStruct());
  }

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
