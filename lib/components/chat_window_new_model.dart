import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chat_window_new_widget.dart' show ChatWindowNewWidget;
import 'package:flutter/material.dart';

class ChatWindowNewModel extends FlutterFlowModel<ChatWindowNewWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in chatWindowNew widget.
  List<ChatsDocumentsRecord>? checkingForChats;
  // Stores action output result for [Backend Call - Create Document] action in chatWindowNew widget.
  ChatsDocumentsRecord? createdFirstChat;
  // State field(s) for ColumnOldChats widget.
  ScrollController? columnOldChats;
  // State field(s) for ChatEntrytTEXT widget.
  FocusNode? chatEntrytTEXTFocusNode;
  TextEditingController? chatEntrytTEXTTextController;
  String? Function(BuildContext, String?)?
      chatEntrytTEXTTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatsDocumentsRecord? createdThread2;

  @override
  void initState(BuildContext context) {
    columnOldChats = ScrollController();
  }

  @override
  void dispose() {
    columnOldChats?.dispose();
    chatEntrytTEXTFocusNode?.dispose();
    chatEntrytTEXTTextController?.dispose();
  }
}
