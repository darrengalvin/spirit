import '/backend/backend.dart';
import '/components/chat_window_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'j_t_p_chat_widget.dart' show JTPChatWidget;
import 'package:flutter/material.dart';

class JTPChatModel extends FlutterFlowModel<JTPChatWidget> {
  ///  Local state fields for this page.

  String selectedMonth = 'August';

  DateTime? selectedMonthDate;

  DateTime? selectedDate;

  AwarenessDaysRecord? selectedDayItem;

  bool moreAwareness = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in JTPChat widget.
  CompaniesRecord? companyQuery;
  // Model for sidemenu component.
  late SidemenuModel sidemenuModel;
  // Model for chatWindow component.
  late ChatWindowModel chatWindowModel;

  @override
  void initState(BuildContext context) {
    sidemenuModel = createModel(context, () => SidemenuModel());
    chatWindowModel = createModel(context, () => ChatWindowModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sidemenuModel.dispose();
    chatWindowModel.dispose();
  }
}
