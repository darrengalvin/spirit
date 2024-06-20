import '/backend/backend.dart';
import '/components/empty_items_widget.dart';
import '/components/list_od_days_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/list_views/list_of_days_facebook/list_of_days_facebook_widget.dart';
import '/pages/list_views/list_of_days_linkedin/list_of_days_linkedin_widget.dart';
import '/pages/list_views/list_of_days_x/list_of_days_x_widget.dart';
import 'j_t_p_topics_widget.dart' show JTPTopicsWidget;
import 'package:flutter/material.dart';

class JTPTopicsModel extends FlutterFlowModel<JTPTopicsWidget> {
  ///  Local state fields for this page.

  String selectedMonth = 'August';

  DateTime? selectedMonthDate;

  DateTime? selectedDate;

  AwarenessDaysRecord? selectedDayItem;

  bool moreAwareness = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sidemenu component.
  late SidemenuModel sidemenuModel;
  // Stores action output result for [Firestore Query - Query a collection] action in DatePickerTimelineWidget widget.
  List<AwarenessDaysRecord>? onDateChangeIndex;
  // Stores action output result for [Firestore Query - Query a collection] action in DatePickerTimelineWidget widget.
  List<AwarenessDaysRecord>? onDateChangeIndexNotSingle;
  // Model for listOfDaysFacebook component.
  late ListOfDaysFacebookModel listOfDaysFacebookModel;
  // Model for listOfDaysLinkedin component.
  late ListOfDaysLinkedinModel listOfDaysLinkedinModel;
  // Model for listOdDays component.
  late ListOdDaysModel listOdDaysModel;
  // Model for listOfDaysX component.
  late ListOfDaysXModel listOfDaysXModel;
  // Model for emptyItems component.
  late EmptyItemsModel emptyItemsModel1;
  // Model for emptyItems component.
  late EmptyItemsModel emptyItemsModel2;

  @override
  void initState(BuildContext context) {
    sidemenuModel = createModel(context, () => SidemenuModel());
    listOfDaysFacebookModel =
        createModel(context, () => ListOfDaysFacebookModel());
    listOfDaysLinkedinModel =
        createModel(context, () => ListOfDaysLinkedinModel());
    listOdDaysModel = createModel(context, () => ListOdDaysModel());
    listOfDaysXModel = createModel(context, () => ListOfDaysXModel());
    emptyItemsModel1 = createModel(context, () => EmptyItemsModel());
    emptyItemsModel2 = createModel(context, () => EmptyItemsModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sidemenuModel.dispose();
    listOfDaysFacebookModel.dispose();
    listOfDaysLinkedinModel.dispose();
    listOdDaysModel.dispose();
    listOfDaysXModel.dispose();
    emptyItemsModel1.dispose();
    emptyItemsModel2.dispose();
  }
}
