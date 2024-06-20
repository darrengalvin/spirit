import '/backend/backend.dart';
import '/components/settings_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'j_t_p_settings_widget.dart' show JTPSettingsWidget;
import 'package:flutter/material.dart';

class JTPSettingsModel extends FlutterFlowModel<JTPSettingsWidget> {
  ///  Local state fields for this page.

  String selectedMonth = 'August';

  DateTime? selectedMonthDate;

  DateTime? selectedDate;

  AwarenessDaysRecord? selectedDayItem;

  bool moreAwareness = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in JTPSettings widget.
  CompaniesRecord? companyQuery;
  // Model for sidemenu component.
  late SidemenuModel sidemenuModel;
  // Model for SETTINGS component.
  late SettingsModel settingsModel;

  @override
  void initState(BuildContext context) {
    sidemenuModel = createModel(context, () => SidemenuModel());
    settingsModel = createModel(context, () => SettingsModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sidemenuModel.dispose();
    settingsModel.dispose();
  }
}
