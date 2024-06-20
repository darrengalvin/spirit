import '/backend/backend.dart';
import '/components/sidemenu_widget.dart';
import '/components/the_acticvity_widget.dart';
import '/components/today_information_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'j_t_p_dash_widget.dart' show JTPDashWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class JTPDashModel extends FlutterFlowModel<JTPDashWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sidemenu component.
  late SidemenuModel sidemenuModel;
  // Stores action output result for [Firestore Query - Query a collection] action in DatePickerTimelineWidget widget.
  AwarenessDaysRecord? onDateChangeIndex;
  // Model for todayInformation component.
  late TodayInformationModel todayInformationModel;
  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;
  // Model for theActicvity component.
  late TheActicvityModel theActicvityModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController4;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController5;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController6;

  @override
  void initState(BuildContext context) {
    sidemenuModel = createModel(context, () => SidemenuModel());
    todayInformationModel = createModel(context, () => TodayInformationModel());
    swipeableStackController = CardSwiperController();
    theActicvityModel = createModel(context, () => TheActicvityModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sidemenuModel.dispose();
    todayInformationModel.dispose();
    theActicvityModel.dispose();
    expandableExpandableController1.dispose();
    expandableExpandableController2.dispose();
    expandableExpandableController3.dispose();
    expandableExpandableController4.dispose();
    expandableExpandableController5.dispose();
    expandableExpandableController6.dispose();
  }
}
