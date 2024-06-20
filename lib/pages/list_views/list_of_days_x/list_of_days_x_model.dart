import '/flutter_flow/flutter_flow_util.dart';
import 'list_of_days_x_widget.dart' show ListOfDaysXWidget;
import 'package:flutter/material.dart';

class ListOfDaysXModel extends FlutterFlowModel<ListOfDaysXWidget> {
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
