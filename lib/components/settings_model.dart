import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for makeLink widget.
  FocusNode? makeLinkFocusNode;
  TextEditingController? makeLinkTextController;
  String? Function(BuildContext, String?)? makeLinkTextControllerValidator;
  // State field(s) for teacherName widget.
  FocusNode? teacherNameFocusNode;
  TextEditingController? teacherNameTextController;
  String? Function(BuildContext, String?)? teacherNameTextControllerValidator;
  // State field(s) for teacherSchool widget.
  FocusNode? teacherSchoolFocusNode;
  TextEditingController? teacherSchoolTextController;
  String? Function(BuildContext, String?)? teacherSchoolTextControllerValidator;
  // State field(s) for teacherEmail widget.
  FocusNode? teacherEmailFocusNode;
  TextEditingController? teacherEmailTextController;
  String? Function(BuildContext, String?)? teacherEmailTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TeachersRecord? createdTeacher;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    makeLinkFocusNode?.dispose();
    makeLinkTextController?.dispose();

    teacherNameFocusNode?.dispose();
    teacherNameTextController?.dispose();

    teacherSchoolFocusNode?.dispose();
    teacherSchoolTextController?.dispose();

    teacherEmailFocusNode?.dispose();
    teacherEmailTextController?.dispose();
  }
}
