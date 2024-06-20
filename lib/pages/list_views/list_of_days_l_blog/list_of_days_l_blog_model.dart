import '/flutter_flow/flutter_flow_util.dart';
import 'list_of_days_l_blog_widget.dart' show ListOfDaysLBlogWidget;
import 'package:flutter/material.dart';

class ListOfDaysLBlogModel extends FlutterFlowModel<ListOfDaysLBlogWidget> {
  ///  Local state fields for this component.

  String showItem = 'activities';

  ///  State fields for stateful widgets in this component.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
