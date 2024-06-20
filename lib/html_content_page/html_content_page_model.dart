import '/flutter_flow/flutter_flow_util.dart';
import 'html_content_page_widget.dart' show HtmlContentPageWidget;
import 'package:flutter/material.dart';

class HtmlContentPageModel extends FlutterFlowModel<HtmlContentPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
