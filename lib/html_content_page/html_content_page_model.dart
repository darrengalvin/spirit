import '/flutter_flow/flutter_flow_util.dart';
import 'html_content_page_widget.dart' show HtmlContentPageWidget;
import 'package:flutter/material.dart';

class HtmlContentPageModel extends FlutterFlowModel<HtmlContentPageWidget> {
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
  FocusNode? activityAgeGroupEditFocusNode1;
  TextEditingController? activityAgeGroupEditTextController1;
  String? Function(BuildContext, String?)?
      activityAgeGroupEditTextController1Validator;
  // State field(s) for activityAgeGroupEdit widget.
  FocusNode? activityAgeGroupEditFocusNode2;
  TextEditingController? activityAgeGroupEditTextController2;
  String? Function(BuildContext, String?)?
      activityAgeGroupEditTextController2Validator;
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

    activityAgeGroupEditFocusNode1?.dispose();
    activityAgeGroupEditTextController1?.dispose();

    activityAgeGroupEditFocusNode2?.dispose();
    activityAgeGroupEditTextController2?.dispose();

    itemadddFocusNode?.dispose();
    itemadddTextController?.dispose();
  }
}