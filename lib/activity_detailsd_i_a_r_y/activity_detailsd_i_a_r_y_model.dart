import '/flutter_flow/flutter_flow_util.dart';
import 'activity_detailsd_i_a_r_y_widget.dart' show ActivityDetailsdIARYWidget;
import 'package:flutter/material.dart';

class ActivityDetailsdIARYModel
    extends FlutterFlowModel<ActivityDetailsdIARYWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for activityNameEdit widget.
  FocusNode? activityNameEditFocusNode;
  TextEditingController? activityNameEditTextController;
  String? Function(BuildContext, String?)?
      activityNameEditTextControllerValidator;
  // State field(s) for activitySummaryEdit widget.
  FocusNode? activitySummaryEditFocusNode;
  TextEditingController? activitySummaryEditTextController;
  String? Function(BuildContext, String?)?
      activitySummaryEditTextControllerValidator;
  // State field(s) for activityAgeGroupEdit widget.
  FocusNode? activityAgeGroupEditFocusNode;
  TextEditingController? activityAgeGroupEditTextController;
  String? Function(BuildContext, String?)?
      activityAgeGroupEditTextControllerValidator;
  // State field(s) for descriptionAdd widget.
  FocusNode? descriptionAddFocusNode;
  TextEditingController? descriptionAddTextController;
  String? Function(BuildContext, String?)?
      descriptionAddTextControllerValidator;
  // State field(s) for itemaddd widget.
  FocusNode? itemadddFocusNode;
  TextEditingController? itemadddTextController;
  String? Function(BuildContext, String?)? itemadddTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    activityNameEditFocusNode?.dispose();
    activityNameEditTextController?.dispose();

    activitySummaryEditFocusNode?.dispose();
    activitySummaryEditTextController?.dispose();

    activityAgeGroupEditFocusNode?.dispose();
    activityAgeGroupEditTextController?.dispose();

    descriptionAddFocusNode?.dispose();
    descriptionAddTextController?.dispose();

    itemadddFocusNode?.dispose();
    itemadddTextController?.dispose();
  }
}
