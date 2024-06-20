import '/backend/backend.dart';
import '/components/cart_widget.dart';
import '/components/empty_items_widget.dart';
import '/components/list_od_days_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/list_views/list_of_days_facebook/list_of_days_facebook_widget.dart';
import '/pages/list_views/list_of_days_l_blog/list_of_days_l_blog_widget.dart';
import '/pages/list_views/list_of_days_l_email/list_of_days_l_email_widget.dart';
import '/pages/list_views/list_of_days_l_whats_app/list_of_days_l_whats_app_widget.dart';
import '/pages/list_views/list_of_days_linkedin/list_of_days_linkedin_widget.dart';
import '/pages/list_views/list_of_days_x/list_of_days_x_widget.dart';
import 'j_t_p_calendar_view_widget.dart' show JTPCalendarViewWidget;
import 'package:flutter/material.dart';

class JTPCalendarViewModel extends FlutterFlowModel<JTPCalendarViewWidget> {
  ///  Local state fields for this page.

  String selectedMonth = 'August';

  DateTime? selectedMonthDate;

  DateTime? selectedDate;

  AwarenessDaysRecord? selectedDayItem;

  bool moreAwareness = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in JTPCalendarView widget.
  CompaniesRecord? companyQuery;
  // Model for sidemenu component.
  late SidemenuModel sidemenuModel;
  // State field(s) for Checkbox widget.
  Map<ActivitiesRecord, bool> checkboxValueMap1 = {};
  List<ActivitiesRecord> get checkboxCheckedItems1 => checkboxValueMap1.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Model for listOfDaysFacebook component.
  late ListOfDaysFacebookModel listOfDaysFacebookModel1;
  // Model for listOfDaysLinkedin component.
  late ListOfDaysLinkedinModel listOfDaysLinkedinModel1;
  // Model for listOdDays component.
  late ListOdDaysModel listOdDaysModel1;
  // Model for listOfDaysX component.
  late ListOfDaysXModel listOfDaysXModel1;
  // Model for listOfDaysLEmail component.
  late ListOfDaysLEmailModel listOfDaysLEmailModel1;
  // Model for listOfDaysLWhatsApp component.
  late ListOfDaysLWhatsAppModel listOfDaysLWhatsAppModel1;
  // Model for listOfDaysLBlog component.
  late ListOfDaysLBlogModel listOfDaysLBlogModel1;
  // Model for emptyItems component.
  late EmptyItemsModel emptyItemsModel1;
  // Model for emptyItems component.
  late EmptyItemsModel emptyItemsModel2;
  // State field(s) for Checkbox widget.
  Map<ActivitiesRecord, bool> checkboxValueMap2 = {};
  List<ActivitiesRecord> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for listOfDaysFacebook component.
  late ListOfDaysFacebookModel listOfDaysFacebookModel2;
  // Model for listOfDaysLinkedin component.
  late ListOfDaysLinkedinModel listOfDaysLinkedinModel2;
  // Model for listOdDays component.
  late ListOdDaysModel listOdDaysModel2;
  // Model for listOfDaysX component.
  late ListOfDaysXModel listOfDaysXModel2;
  // Model for listOfDaysLEmail component.
  late ListOfDaysLEmailModel listOfDaysLEmailModel2;
  // Model for listOfDaysLWhatsApp component.
  late ListOfDaysLWhatsAppModel listOfDaysLWhatsAppModel2;
  // Model for listOfDaysLBlog component.
  late ListOfDaysLBlogModel listOfDaysLBlogModel2;
  // Model for emptyItems component.
  late EmptyItemsModel emptyItemsModel3;
  // Model for emptyItems component.
  late EmptyItemsModel emptyItemsModel4;
  // Model for cart component.
  late CartModel cartModel;

  @override
  void initState(BuildContext context) {
    sidemenuModel = createModel(context, () => SidemenuModel());
    listOfDaysFacebookModel1 =
        createModel(context, () => ListOfDaysFacebookModel());
    listOfDaysLinkedinModel1 =
        createModel(context, () => ListOfDaysLinkedinModel());
    listOdDaysModel1 = createModel(context, () => ListOdDaysModel());
    listOfDaysXModel1 = createModel(context, () => ListOfDaysXModel());
    listOfDaysLEmailModel1 =
        createModel(context, () => ListOfDaysLEmailModel());
    listOfDaysLWhatsAppModel1 =
        createModel(context, () => ListOfDaysLWhatsAppModel());
    listOfDaysLBlogModel1 = createModel(context, () => ListOfDaysLBlogModel());
    emptyItemsModel1 = createModel(context, () => EmptyItemsModel());
    emptyItemsModel2 = createModel(context, () => EmptyItemsModel());
    listOfDaysFacebookModel2 =
        createModel(context, () => ListOfDaysFacebookModel());
    listOfDaysLinkedinModel2 =
        createModel(context, () => ListOfDaysLinkedinModel());
    listOdDaysModel2 = createModel(context, () => ListOdDaysModel());
    listOfDaysXModel2 = createModel(context, () => ListOfDaysXModel());
    listOfDaysLEmailModel2 =
        createModel(context, () => ListOfDaysLEmailModel());
    listOfDaysLWhatsAppModel2 =
        createModel(context, () => ListOfDaysLWhatsAppModel());
    listOfDaysLBlogModel2 = createModel(context, () => ListOfDaysLBlogModel());
    emptyItemsModel3 = createModel(context, () => EmptyItemsModel());
    emptyItemsModel4 = createModel(context, () => EmptyItemsModel());
    cartModel = createModel(context, () => CartModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sidemenuModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    listOfDaysFacebookModel1.dispose();
    listOfDaysLinkedinModel1.dispose();
    listOdDaysModel1.dispose();
    listOfDaysXModel1.dispose();
    listOfDaysLEmailModel1.dispose();
    listOfDaysLWhatsAppModel1.dispose();
    listOfDaysLBlogModel1.dispose();
    emptyItemsModel1.dispose();
    emptyItemsModel2.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    listOfDaysFacebookModel2.dispose();
    listOfDaysLinkedinModel2.dispose();
    listOdDaysModel2.dispose();
    listOfDaysXModel2.dispose();
    listOfDaysLEmailModel2.dispose();
    listOfDaysLWhatsAppModel2.dispose();
    listOfDaysLBlogModel2.dispose();
    emptyItemsModel3.dispose();
    emptyItemsModel4.dispose();
    cartModel.dispose();
  }
}
