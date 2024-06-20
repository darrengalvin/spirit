import '/backend/backend.dart';
import '/components/empty_items_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_of_days_facebook_widget.dart' show ListOfDaysFacebookWidget;
import 'package:flutter/material.dart';

class ListOfDaysFacebookModel
    extends FlutterFlowModel<ListOfDaysFacebookWidget> {
  ///  Local state fields for this component.

  String showItem = 'activities';

  ///  State fields for stateful widgets in this component.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  AwarenessDaysRecord? awarenessDate;
  // Model for emptyItems component.
  late EmptyItemsModel emptyItemsModel;

  @override
  void initState(BuildContext context) {
    emptyItemsModel = createModel(context, () => EmptyItemsModel());
  }

  @override
  void dispose() {
    emptyItemsModel.dispose();
  }
}
