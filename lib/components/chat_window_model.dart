import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chat_window_widget.dart' show ChatWindowWidget;
import 'package:flutter/material.dart';

class ChatWindowModel extends FlutterFlowModel<ChatWindowWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in chatWindow widget.
  List<ChatsDocumentsRecord>? checkingForChats;
  // Stores action output result for [Backend Call - Create Document] action in chatWindow widget.
  ChatsDocumentsRecord? createdFirstChat;
  // State field(s) for ColumnPoss widget.
  ScrollController? columnPoss;
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
    columnPoss = ScrollController();
    columnOldChats = ScrollController();
  }

  @override
  void dispose() {
    columnPoss?.dispose();
    columnOldChats?.dispose();
    chatEntrytTEXTFocusNode?.dispose();
    chatEntrytTEXTTextController?.dispose();
  }
}
