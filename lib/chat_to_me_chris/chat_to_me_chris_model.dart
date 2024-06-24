import '/backend/backend.dart';
import '/components/chat_window_new_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chat_to_me_chris_widget.dart' show ChatToMeChrisWidget;
import 'package:flutter/material.dart';

class ChatToMeChrisModel extends FlutterFlowModel<ChatToMeChrisWidget> {
  ///  Local state fields for this page.

  String selectedMonth = 'August';

  DateTime? selectedMonthDate;

  DateTime? selectedDate;

  AwarenessDaysRecord? selectedDayItem;

  bool moreAwareness = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in chatToMeChris widget.
  CompaniesRecord? companyQuery;
  // Model for sidemenu component.
  late SidemenuModel sidemenuModel;
  // Model for chatWindowNew component.
  late ChatWindowNewModel chatWindowNewModel1;
  // Model for chatWindowNew component.
  late ChatWindowNewModel chatWindowNewModel2;

  @override
  void initState(BuildContext context) {
    sidemenuModel = createModel(context, () => SidemenuModel());
    chatWindowNewModel1 = createModel(context, () => ChatWindowNewModel());
    chatWindowNewModel2 = createModel(context, () => ChatWindowNewModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sidemenuModel.dispose();
    chatWindowNewModel1.dispose();
    chatWindowNewModel2.dispose();
  }
}
