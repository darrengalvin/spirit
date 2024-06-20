import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/cart_widget.dart';
import '/components/empty_items_widget.dart';
import '/components/list_od_days_widget.dart';
import '/components/list_widget.dart';
import '/components/login_box_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/list_views/list_of_days_facebook/list_of_days_facebook_widget.dart';
import '/pages/list_views/list_of_days_l_blog/list_of_days_l_blog_widget.dart';
import '/pages/list_views/list_of_days_l_email/list_of_days_l_email_widget.dart';
import '/pages/list_views/list_of_days_l_whats_app/list_of_days_l_whats_app_widget.dart';
import '/pages/list_views/list_of_days_linkedin/list_of_days_linkedin_widget.dart';
import '/pages/list_views/list_of_days_x/list_of_days_x_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'j_t_p_calendar_view_model.dart';
export 'j_t_p_calendar_view_model.dart';

class JTPCalendarViewWidget extends StatefulWidget {
  const JTPCalendarViewWidget({super.key});

  @override
  State<JTPCalendarViewWidget> createState() => _JTPCalendarViewWidgetState();
}

class _JTPCalendarViewWidgetState extends State<JTPCalendarViewWidget>
    with TickerProviderStateMixin {
  late JTPCalendarViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JTPCalendarViewModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.companyQuery = await queryCompaniesRecordOnce(
        queryBuilder: (companiesRecord) => companiesRecord.where(
          'companyId',
          isEqualTo: loggedIn
              ? valueOrDefault<String>(
                  valueOrDefault(currentUserDocument?.associatedCompanyId, ''),
                  '0',
                )
              : 'wh1sZDHws5iYvqMG2sUk',
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      FFAppState().selectedCompanyId = FFAppState().selectedCompanyId;
      setState(() {});
      if (!loggedIn) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () => _model.unfocusNode.canRequestFocus
                  ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                  : FocusScope.of(context).unfocus(),
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: LoginBoxWidget(
                  companyDoc: _model.companyQuery!,
                ),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
      if (FFAppState().selectedDate == null) {
        FFAppState().selectedDate =
            functions.getDayAndMonth(getCurrentTimestamp);
        setState(() {});
      }
    });

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1510.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1510.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          top: true,
          child: StreamBuilder<List<CompaniesRecord>>(
            stream: queryCompaniesRecord(
              queryBuilder: (companiesRecord) => companiesRecord
                  .where(
                    'companyId',
                    isEqualTo: valueOrDefault<String>(
                      FFAppState().selectedCompanyId,
                      'wh1sZDHws5iYvqMG2sUk',
                    ),
                  )
                  .where(
                    'members',
                    arrayContains: currentUserReference?.id,
                  ),
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                );
              }
              List<CompaniesRecord> containerCompaniesRecordList =
                  snapshot.data!;
              return Container(
                decoration: const BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 260.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              containerCompaniesRecordList.first.primaryColor,
                        ),
                        child: wrapWithModel(
                          model: _model.sidemenuModel,
                          updateCallback: () => setState(() {}),
                          updateOnChange: true,
                          child: SidemenuWidget(
                            companyDoc: containerCompaniesRecordList.first,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Stack(
                        children: [
                          StreamBuilder<List<AwarenessDaysRecord>>(
                            stream: queryAwarenessDaysRecord(
                              queryBuilder: (awarenessDaysRecord) =>
                                  awarenessDaysRecord.where(
                                'date',
                                isEqualTo: FFAppState().selectedDate,
                              ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<AwarenessDaysRecord>
                                  containerAwarenessDaysRecordList =
                                  snapshot.data!;
                              return Container(
                                decoration: BoxDecoration(
                                  color: containerCompaniesRecordList
                                      .first.primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      25.0, 0.0, 25.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      FFAppState().showItem = 'whatsapp';
                                      setState(() {});
                                    },
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  FFAppState().showBasket =
                                                      false;
                                                  setState(() {});
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  1.0, -1.0),
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                if (responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                  tablet: false,
                                                                ))
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            25.0,
                                                                            0.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      child: Image
                                                                          .network(
                                                                        getCORSProxyUrl(
                                                                          containerCompaniesRecordList
                                                                              .first
                                                                              .companyLogo,
                                                                        ),
                                                                        width:
                                                                            200.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Divider(
                                                          thickness: 1.0,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                        ),
                                                        const Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [],
                                                        ),
                                                        StreamBuilder<
                                                            List<
                                                                AwarenessDaysRecord>>(
                                                          stream:
                                                              queryAwarenessDaysRecord(
                                                            queryBuilder:
                                                                (awarenessDaysRecord) =>
                                                                    awarenessDaysRecord
                                                                        .where(
                                                                          'date',
                                                                          isEqualTo:
                                                                              FFAppState().selectedDate,
                                                                        )
                                                                        .where(
                                                                          'selected',
                                                                          isEqualTo:
                                                                              true,
                                                                        )
                                                                        .where(
                                                                          'companyOwner',
                                                                          isEqualTo:
                                                                              FFAppState().selectedCompanyId,
                                                                        ),
                                                            singleRecord: true,
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<AwarenessDaysRecord>
                                                                janContainerAwarenessDaysRecordList =
                                                                snapshot.data!;
                                                            final janContainerAwarenessDaysRecord =
                                                                janContainerAwarenessDaysRecordList
                                                                        .isNotEmpty
                                                                    ? janContainerAwarenessDaysRecordList
                                                                        .first
                                                                    : null;
                                                            return Container(
                                                              decoration:
                                                                  const BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if (responsiveVisibility(
                                                                    context:
                                                                        context,
                                                                    phone:
                                                                        false,
                                                                    tablet:
                                                                        false,
                                                                  ))
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (FFAppState().pageSelected ==
                                                                                'themes') {
                                                                              return Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                    height: 1000.0,
                                                                                    child: custom_widgets.AwarenessDayCalendar(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                      height: 1000.0,
                                                                                      onDateChange: () async {
                                                                                        setState(() {});
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            } else if (FFAppState().pageSelected ==
                                                                                'news') {
                                                                              return Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                    height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                    child: custom_widgets.NewsDayCalendar(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                      height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                      onDateChange: () async {},
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            } else {
                                                                              return Visibility(
                                                                                visible: FFAppState().showDates == false,
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    if (responsiveVisibility(
                                                                                      context: context,
                                                                                      phone: false,
                                                                                      tablet: false,
                                                                                    ))
                                                                                      SizedBox(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                        height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                        child: custom_widgets.AwarenessDayCalendar(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                          height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                          onDateChange: () async {
                                                                                            setState(() {});
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    Container(
                                                                                      decoration: const BoxDecoration(),
                                                                                      child: Visibility(
                                                                                        visible: responsiveVisibility(
                                                                                          context: context,
                                                                                          tabletLandscape: false,
                                                                                          desktop: false,
                                                                                        ),
                                                                                        child: Builder(
                                                                                          builder: (context) {
                                                                                            if (valueOrDefault<bool>(
                                                                                              valueOrDefault<bool>(
                                                                                                    ((containerAwarenessDaysRecordList.first.linkedActivity.isNotEmpty) == true) && (FFAppState().showItem == 'activities'),
                                                                                                    false,
                                                                                                  ) ||
                                                                                                  valueOrDefault<bool>(
                                                                                                    ((containerAwarenessDaysRecordList.first.linkedFb.isNotEmpty) == true) && (FFAppState().showItem == 'facebook'),
                                                                                                    false,
                                                                                                  ) ||
                                                                                                  valueOrDefault<bool>(
                                                                                                    ((containerAwarenessDaysRecordList.first.linkedEmail.isNotEmpty) == true) && (FFAppState().showItem == 'teachers'),
                                                                                                    false,
                                                                                                  ) ||
                                                                                                  valueOrDefault<bool>(
                                                                                                    ((containerAwarenessDaysRecordList.first.linkedLinkedin.isNotEmpty) == true) && (FFAppState().showItem == 'linkedin'),
                                                                                                    false,
                                                                                                  ) ||
                                                                                                  valueOrDefault<bool>(
                                                                                                    ((containerAwarenessDaysRecordList.first.linkedBlog.isNotEmpty) == true) && (FFAppState().showItem == 'blog'),
                                                                                                    false,
                                                                                                  ) ||
                                                                                                  valueOrDefault<bool>(
                                                                                                    ((containerAwarenessDaysRecordList.first.linkedX.isNotEmpty) == true) && (FFAppState().showItem == 'x'),
                                                                                                    false,
                                                                                                  ) ||
                                                                                                  valueOrDefault<bool>(
                                                                                                    ((containerAwarenessDaysRecordList.first.linkedWhatsapp.isNotEmpty) == true) && (FFAppState().showItem == 'whatsapp'),
                                                                                                    false,
                                                                                                  ),
                                                                                              false,
                                                                                            )) {
                                                                                              return Builder(
                                                                                                builder: (context) {
                                                                                                  if (valueOrDefault<bool>(
                                                                                                    FFAppState().showItem == 'activities',
                                                                                                    true,
                                                                                                  )) {
                                                                                                    return Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        StreamBuilder<List<ActivitiesRecord>>(
                                                                                                          stream: queryActivitiesRecord(
                                                                                                            queryBuilder: (activitiesRecord) => activitiesRecord
                                                                                                                .where(
                                                                                                                  'activityDate',
                                                                                                                  isEqualTo: FFAppState().selectedDate,
                                                                                                                )
                                                                                                                .where(
                                                                                                                  'linkedAwarenessDayId',
                                                                                                                  isEqualTo: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                                ),
                                                                                                          ),
                                                                                                          builder: (context, snapshot) {
                                                                                                            // Customize what your widget looks like when it's loading.
                                                                                                            if (!snapshot.hasData) {
                                                                                                              return const Center(
                                                                                                                child: SizedBox(
                                                                                                                  width: 400.0,
                                                                                                                  height: 250.0,
                                                                                                                  child: ListWidget(),
                                                                                                                ),
                                                                                                              );
                                                                                                            }
                                                                                                            List<ActivitiesRecord> containerActivitiesRecordList = snapshot.data!;
                                                                                                            return Container(
                                                                                                              decoration: const BoxDecoration(),
                                                                                                              child: SingleChildScrollView(
                                                                                                                child: Column(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                  children: [
                                                                                                                    Container(
                                                                                                                      constraints: const BoxConstraints(
                                                                                                                        maxWidth: 800.0,
                                                                                                                      ),
                                                                                                                      decoration: const BoxDecoration(),
                                                                                                                      child: Column(
                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                        children: [
                                                                                                                          Builder(
                                                                                                                            builder: (context) {
                                                                                                                              final activitiesRow = containerActivitiesRecordList.toList();
                                                                                                                              return SingleChildScrollView(
                                                                                                                                scrollDirection: Axis.horizontal,
                                                                                                                                child: Row(
                                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                                  children: List.generate(activitiesRow.length, (activitiesRowIndex) {
                                                                                                                                    final activitiesRowItem = activitiesRow[activitiesRowIndex];
                                                                                                                                    return InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        context.pushNamed(
                                                                                                                                          'activityDetails',
                                                                                                                                          queryParameters: {
                                                                                                                                            'activityRef': serializeParam(
                                                                                                                                              activitiesRowItem.reference,
                                                                                                                                              ParamType.DocumentReference,
                                                                                                                                            ),
                                                                                                                                            'companyDoc': serializeParam(
                                                                                                                                              containerCompaniesRecordList.first,
                                                                                                                                              ParamType.Document,
                                                                                                                                            ),
                                                                                                                                          }.withoutNulls,
                                                                                                                                          extra: <String, dynamic>{
                                                                                                                                            'companyDoc': containerCompaniesRecordList.first,
                                                                                                                                          },
                                                                                                                                        );
                                                                                                                                      },
                                                                                                                                      child: Column(
                                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                                        children: [
                                                                                                                                          Padding(
                                                                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
                                                                                                                                            child: Container(
                                                                                                                                              width: 400.0,
                                                                                                                                              constraints: const BoxConstraints(
                                                                                                                                                maxWidth: 500.0,
                                                                                                                                              ),
                                                                                                                                              decoration: BoxDecoration(
                                                                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                                                boxShadow: const [
                                                                                                                                                  BoxShadow(
                                                                                                                                                    blurRadius: 2.0,
                                                                                                                                                    color: Color(0x520E151B),
                                                                                                                                                    offset: Offset(
                                                                                                                                                      0.0,
                                                                                                                                                      1.0,
                                                                                                                                                    ),
                                                                                                                                                  )
                                                                                                                                                ],
                                                                                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                                                                                              ),
                                                                                                                                              child: Column(
                                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                children: [
                                                                                                                                                  SizedBox(
                                                                                                                                                    height: 300.0,
                                                                                                                                                    child: Stack(
                                                                                                                                                      children: [
                                                                                                                                                        ClipRRect(
                                                                                                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                                                                                                          child: Image.network(
                                                                                                                                                            getCORSProxyUrl(
                                                                                                                                                              valueOrDefault<String>(
                                                                                                                                                                activitiesRowItem.activityImage,
                                                                                                                                                                'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDJ8fHByb2R1Y3RzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                            width: double.infinity,
                                                                                                                                                            height: 300.0,
                                                                                                                                                            fit: BoxFit.cover,
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                                                                                        Column(
                                                                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                          children: [
                                                                                                                                                            ClipRRect(
                                                                                                                                                              child: BackdropFilter(
                                                                                                                                                                filter: ImageFilter.blur(
                                                                                                                                                                  sigmaX: 2.0,
                                                                                                                                                                  sigmaY: 2.0,
                                                                                                                                                                ),
                                                                                                                                                                child: Align(
                                                                                                                                                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                                                                                                  child: Container(
                                                                                                                                                                    width: 60.0,
                                                                                                                                                                    height: 100.0,
                                                                                                                                                                    decoration: const BoxDecoration(
                                                                                                                                                                      borderRadius: BorderRadius.only(
                                                                                                                                                                        bottomLeft: Radius.circular(12.0),
                                                                                                                                                                        bottomRight: Radius.circular(12.0),
                                                                                                                                                                        topLeft: Radius.circular(0.0),
                                                                                                                                                                        topRight: Radius.circular(0.0),
                                                                                                                                                                      ),
                                                                                                                                                                    ),
                                                                                                                                                                    child: Padding(
                                                                                                                                                                      padding: const EdgeInsets.all(12.0),
                                                                                                                                                                      child: Column(
                                                                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                                        children: [
                                                                                                                                                                          Row(
                                                                                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                                                                                                            children: [
                                                                                                                                                                              Container(
                                                                                                                                                                                width: 50.0,
                                                                                                                                                                                height: 50.0,
                                                                                                                                                                                decoration: const BoxDecoration(),
                                                                                                                                                                                child: Theme(
                                                                                                                                                                                  data: ThemeData(
                                                                                                                                                                                    checkboxTheme: CheckboxThemeData(
                                                                                                                                                                                      shape: RoundedRectangleBorder(
                                                                                                                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                                                                                                                      ),
                                                                                                                                                                                    ),
                                                                                                                                                                                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                                                                  ),
                                                                                                                                                                                  child: Checkbox(
                                                                                                                                                                                    value: _model.checkboxValueMap1[activitiesRowItem] ??= activitiesRowItem.isActive == false,
                                                                                                                                                                                    onChanged: (newValue) async {
                                                                                                                                                                                      setState(() => _model.checkboxValueMap1[activitiesRowItem] = newValue!);
                                                                                                                                                                                      if (newValue!) {
                                                                                                                                                                                        await activitiesRowItem.reference.update(createActivitiesRecordData(
                                                                                                                                                                                          isActive: true,
                                                                                                                                                                                        ));
                                                                                                                                                                                      } else {
                                                                                                                                                                                        await activitiesRowItem.reference.update(createActivitiesRecordData(
                                                                                                                                                                                          isActive: false,
                                                                                                                                                                                        ));
                                                                                                                                                                                      }
                                                                                                                                                                                    },
                                                                                                                                                                                    side: BorderSide(
                                                                                                                                                                                      width: 2,
                                                                                                                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                                                                    ),
                                                                                                                                                                                    activeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                                                                                    checkColor: FlutterFlowTheme.of(context).info,
                                                                                                                                                                                  ),
                                                                                                                                                                                ),
                                                                                                                                                                              ),
                                                                                                                                                                            ],
                                                                                                                                                                          ),
                                                                                                                                                                        ],
                                                                                                                                                                      ),
                                                                                                                                                                    ),
                                                                                                                                                                  ),
                                                                                                                                                                ),
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                            ClipRRect(
                                                                                                                                                              child: BackdropFilter(
                                                                                                                                                                filter: ImageFilter.blur(
                                                                                                                                                                  sigmaX: 2.0,
                                                                                                                                                                  sigmaY: 2.0,
                                                                                                                                                                ),
                                                                                                                                                                child: Container(
                                                                                                                                                                  width: double.infinity,
                                                                                                                                                                  decoration: const BoxDecoration(
                                                                                                                                                                    color: Color(0xB2FFFFFF),
                                                                                                                                                                    borderRadius: BorderRadius.only(
                                                                                                                                                                      bottomLeft: Radius.circular(12.0),
                                                                                                                                                                      bottomRight: Radius.circular(12.0),
                                                                                                                                                                      topLeft: Radius.circular(0.0),
                                                                                                                                                                      topRight: Radius.circular(0.0),
                                                                                                                                                                    ),
                                                                                                                                                                  ),
                                                                                                                                                                  child: Padding(
                                                                                                                                                                    padding: const EdgeInsets.all(12.0),
                                                                                                                                                                    child: Column(
                                                                                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                                      children: [
                                                                                                                                                                        Row(
                                                                                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                                                          children: [
                                                                                                                                                                            Text(
                                                                                                                                                                              activitiesRowItem.activityName,
                                                                                                                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                                                                                    fontFamily: 'Readex Pro',
                                                                                                                                                                                    color: const Color(0xFF0F1113),
                                                                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                                                                  ),
                                                                                                                                                                            ),
                                                                                                                                                                            Text(
                                                                                                                                                                              activitiesRowItem.ageGroup,
                                                                                                                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                                                                                                    fontFamily: 'Outfit',
                                                                                                                                                                                    color: const Color(0xFF0F1113),
                                                                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                                                                  ),
                                                                                                                                                                            ),
                                                                                                                                                                          ],
                                                                                                                                                                        ),
                                                                                                                                                                        Padding(
                                                                                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                                                                                                          child: Text(
                                                                                                                                                                            activitiesRowItem.activitySummary,
                                                                                                                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                                                                                  fontFamily: 'Readex Pro',
                                                                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                                                                ),
                                                                                                                                                                          ),
                                                                                                                                                                        ),
                                                                                                                                                                      ],
                                                                                                                                                                    ),
                                                                                                                                                                  ),
                                                                                                                                                                ),
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                          ],
                                                                                                                                                        ),
                                                                                                                                                      ],
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ],
                                                                                                                                              ),
                                                                                                                                            ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
                                                                                                                                          ),
                                                                                                                                        ],
                                                                                                                                      ),
                                                                                                                                    );
                                                                                                                                  }),
                                                                                                                                ),
                                                                                                                              );
                                                                                                                            },
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            if (responsiveVisibility(
                                                                                                              context: context,
                                                                                                              phone: false,
                                                                                                              tablet: false,
                                                                                                              tabletLandscape: false,
                                                                                                              desktop: false,
                                                                                                            ))
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                                                                                                                child: FFButtonWidget(
                                                                                                                  onPressed: () async {
                                                                                                                    await ReadyToProcessRecord.collection.doc().set(createReadyToProcessRecordData(
                                                                                                                          awarenessDayDetails: createAwarenessStruct(
                                                                                                                            awarenessDay: containerAwarenessDaysRecordList.first.item,
                                                                                                                            awarenessIdString: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                                            awarenessdate: containerAwarenessDaysRecordList.first.date,
                                                                                                                            clearUnsetFields: false,
                                                                                                                            create: true,
                                                                                                                          ),
                                                                                                                          jobNumber: random_data.randomString(
                                                                                                                            9,
                                                                                                                            9,
                                                                                                                            true,
                                                                                                                            false,
                                                                                                                            false,
                                                                                                                          ),
                                                                                                                          status: 'pending',
                                                                                                                          type: 'Activity Generation',
                                                                                                                          dateCreated: getCurrentTimestamp,
                                                                                                                        ));
                                                                                                                    FFAppState().showBasket = true;
                                                                                                                    _model.updatePage(() {});
                                                                                                                  },
                                                                                                                  text: 'Get Another Activity',
                                                                                                                  options: FFButtonOptions(
                                                                                                                    width: 160.0,
                                                                                                                    height: 34.0,
                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                                    color: containerCompaniesRecordList.first.secondaryColor,
                                                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                          fontFamily: 'Readex Pro',
                                                                                                                          color: Colors.white,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                    elevation: 3.0,
                                                                                                                    borderSide: const BorderSide(
                                                                                                                      color: Colors.transparent,
                                                                                                                      width: 1.0,
                                                                                                                    ),
                                                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                                                                                                          child: SingleChildScrollView(
                                                                                                            scrollDirection: Axis.horizontal,
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Padding(
                                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                  child: Column(
                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                    children: [
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                                        child: SingleChildScrollView(
                                                                                                                          scrollDirection: Axis.horizontal,
                                                                                                                          child: Row(
                                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                            children: [
                                                                                                                              Column(
                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                    child: InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        FFAppState().showItem = 'activities';
                                                                                                                                        FFAppState().isSearchingActivities = false;
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      child: ClipRRect(
                                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                                        child: Image.asset(
                                                                                                                                          'assets/images/activityicon.png',
                                                                                                                                          width: 50.0,
                                                                                                                                          height: 50.0,
                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Column(
                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                    child: InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        FFAppState().showItem = 'facebook';
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      child: ClipRRect(
                                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                                        child: Image.asset(
                                                                                                                                          'assets/images/facebook.png',
                                                                                                                                          width: 50.0,
                                                                                                                                          height: 50.0,
                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Column(
                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                    child: InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        FFAppState().showItem = 'linkedin';
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      child: ClipRRect(
                                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                                        child: Image.asset(
                                                                                                                                          'assets/images/linkedin.png',
                                                                                                                                          width: 50.0,
                                                                                                                                          height: 50.0,
                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Column(
                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                    child: InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        FFAppState().showItem = 'x';
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      child: ClipRRect(
                                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                                        child: Image.asset(
                                                                                                                                          'assets/images/x_icon.webp',
                                                                                                                                          width: 50.0,
                                                                                                                                          height: 50.0,
                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Column(
                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                    child: InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        FFAppState().showItem = 'teachers';
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      child: ClipRRect(
                                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                                        child: Image.asset(
                                                                                                                                          'assets/images/teachers_icon.png',
                                                                                                                                          width: 50.0,
                                                                                                                                          height: 50.0,
                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Column(
                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                    child: InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        FFAppState().showItem = 'whatsapp';
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      child: ClipRRect(
                                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                                        child: Image.asset(
                                                                                                                                          'assets/images/whatsapp.jpeg',
                                                                                                                                          width: 50.0,
                                                                                                                                          height: 50.0,
                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Column(
                                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                    child: InkWell(
                                                                                                                                      splashColor: Colors.transparent,
                                                                                                                                      focusColor: Colors.transparent,
                                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                                      onTap: () async {
                                                                                                                                        FFAppState().showItem = 'blog';
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      child: ClipRRect(
                                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                                        child: Image.asset(
                                                                                                                                          'assets/images/blof.jpeg',
                                                                                                                                          width: 50.0,
                                                                                                                                          height: 50.0,
                                                                                                                                          fit: BoxFit.cover,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Padding(
                                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                                child: FlutterFlowIconButton(
                                                                                                                                  borderColor: Colors.transparent,
                                                                                                                                  borderRadius: 10.0,
                                                                                                                                  borderWidth: 1.0,
                                                                                                                                  buttonSize: 50.0,
                                                                                                                                  icon: Icon(
                                                                                                                                    Icons.more_time_sharp,
                                                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                                                    size: 40.0,
                                                                                                                                  ),
                                                                                                                                  onPressed: () async {
                                                                                                                                    FFAppState().showBasket = true;
                                                                                                                                    setState(() {});
                                                                                                                                    _model.moreAwareness = !_model.moreAwareness;
                                                                                                                                    setState(() {});
                                                                                                                                  },
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    );
                                                                                                  } else if (FFAppState().showItem == 'facebook') {
                                                                                                    return Container(
                                                                                                      decoration: const BoxDecoration(),
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          StreamBuilder<List<FacebookPostsRecord>>(
                                                                                                            stream: queryFacebookPostsRecord(
                                                                                                              queryBuilder: (facebookPostsRecord) => facebookPostsRecord.where(
                                                                                                                'linkedAwarenessDay',
                                                                                                                isEqualTo: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                              ),
                                                                                                            ),
                                                                                                            builder: (context, snapshot) {
                                                                                                              // Customize what your widget looks like when it's loading.
                                                                                                              if (!snapshot.hasData) {
                                                                                                                return Center(
                                                                                                                  child: SizedBox(
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    child: CircularProgressIndicator(
                                                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                );
                                                                                                              }
                                                                                                              List<FacebookPostsRecord> containerFacebookPostsRecordList = snapshot.data!;
                                                                                                              return Container(
                                                                                                                decoration: const BoxDecoration(),
                                                                                                                child: Visibility(
                                                                                                                  visible: FFAppState().editMode == true,
                                                                                                                  child: Padding(
                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                                    child: TextFormField(
                                                                                                                      controller: _model.textController1 ??= TextEditingController(
                                                                                                                        text: valueOrDefault<String>(
                                                                                                                          containerFacebookPostsRecordList.where((e) => e.dateposted == FFAppState().selectedDate).toList().first.mainText,
                                                                                                                          'maintext',
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      focusNode: _model.textFieldFocusNode1,
                                                                                                                      onChanged: (_) => EasyDebounce.debounce(
                                                                                                                        '_model.textController1',
                                                                                                                        const Duration(milliseconds: 2000),
                                                                                                                        () async {
                                                                                                                          await containerFacebookPostsRecordList.where((e) => e.dateposted == FFAppState().selectedDate).toList().first.reference.update(createFacebookPostsRecordData(
                                                                                                                                description: _model.textController1.text,
                                                                                                                              ));
                                                                                                                        },
                                                                                                                      ),
                                                                                                                      autofocus: true,
                                                                                                                      obscureText: false,
                                                                                                                      decoration: InputDecoration(
                                                                                                                        labelText: 'Label here...',
                                                                                                                        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                              fontFamily: 'Readex Pro',
                                                                                                                              letterSpacing: 0.0,
                                                                                                                            ),
                                                                                                                        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                              fontFamily: 'Readex Pro',
                                                                                                                              letterSpacing: 0.0,
                                                                                                                            ),
                                                                                                                        enabledBorder: UnderlineInputBorder(
                                                                                                                          borderSide: BorderSide(
                                                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                                                            width: 2.0,
                                                                                                                          ),
                                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                                        ),
                                                                                                                        focusedBorder: UnderlineInputBorder(
                                                                                                                          borderSide: BorderSide(
                                                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                                                            width: 2.0,
                                                                                                                          ),
                                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                                        ),
                                                                                                                        errorBorder: UnderlineInputBorder(
                                                                                                                          borderSide: BorderSide(
                                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                                            width: 2.0,
                                                                                                                          ),
                                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                                        ),
                                                                                                                        focusedErrorBorder: UnderlineInputBorder(
                                                                                                                          borderSide: BorderSide(
                                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                                            width: 2.0,
                                                                                                                          ),
                                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            fontFamily: 'Readex Pro',
                                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                            letterSpacing: 0.0,
                                                                                                                          ),
                                                                                                                      maxLines: null,
                                                                                                                      validator: _model.textController1Validator.asValidator(context),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ),
                                                                                                          wrapWithModel(
                                                                                                            model: _model.listOfDaysFacebookModel1,
                                                                                                            updateCallback: () => setState(() {}),
                                                                                                            updateOnChange: true,
                                                                                                            child: ListOfDaysFacebookWidget(
                                                                                                              awarenessDayId: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    );
                                                                                                  } else if (FFAppState().showItem == 'linkedin') {
                                                                                                    return SingleChildScrollView(
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          wrapWithModel(
                                                                                                            model: _model.listOfDaysLinkedinModel1,
                                                                                                            updateCallback: () => setState(() {}),
                                                                                                            child: ListOfDaysLinkedinWidget(
                                                                                                              awarenessDayId: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    );
                                                                                                  } else if (valueOrDefault<bool>(
                                                                                                    FFAppState().showItem == 'switch',
                                                                                                    false,
                                                                                                  )) {
                                                                                                    return Builder(
                                                                                                      builder: (context) {
                                                                                                        if (valueOrDefault<bool>(
                                                                                                          containerAwarenessDaysRecordList.isNotEmpty,
                                                                                                          true,
                                                                                                        )) {
                                                                                                          return Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              wrapWithModel(
                                                                                                                model: _model.listOdDaysModel1,
                                                                                                                updateCallback: () => setState(() {}),
                                                                                                                updateOnChange: true,
                                                                                                                child: ListOdDaysWidget(
                                                                                                                  listOfDaysDocsFiltered: containerAwarenessDaysRecordList,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          );
                                                                                                        } else {
                                                                                                          return Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                'You only have one to choose from, you will need to run again if you wish to see alternatives.',
                                                                                                                textAlign: TextAlign.start,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      fontFamily: 'Readex Pro',
                                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                                      fontSize: 20.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                    ),
                                                                                                              ),
                                                                                                              Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                children: [
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                                                                                                                    child: FFButtonWidget(
                                                                                                                      onPressed: () {
                                                                                                                        print('Button pressed ...');
                                                                                                                      },
                                                                                                                      text: 'Try For more Awareness days',
                                                                                                                      icon: const Icon(
                                                                                                                        Icons.refresh_sharp,
                                                                                                                        size: 30.0,
                                                                                                                      ),
                                                                                                                      options: FFButtonOptions(
                                                                                                                        width: 300.0,
                                                                                                                        height: 35.0,
                                                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                              fontFamily: 'Readex Pro',
                                                                                                                              color: Colors.white,
                                                                                                                              letterSpacing: 0.0,
                                                                                                                            ),
                                                                                                                        elevation: 3.0,
                                                                                                                        borderSide: const BorderSide(
                                                                                                                          color: Colors.transparent,
                                                                                                                          width: 1.0,
                                                                                                                        ),
                                                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation1']!),
                                                                                                            ],
                                                                                                          );
                                                                                                        }
                                                                                                      },
                                                                                                    );
                                                                                                  } else if (valueOrDefault<bool>(
                                                                                                    FFAppState().showItem == 'x',
                                                                                                    false,
                                                                                                  )) {
                                                                                                    return Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        wrapWithModel(
                                                                                                          model: _model.listOfDaysXModel1,
                                                                                                          updateCallback: () => setState(() {}),
                                                                                                          updateOnChange: true,
                                                                                                          child: ListOfDaysXWidget(
                                                                                                            awarenessDayId: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    );
                                                                                                  } else if (FFAppState().showItem == 'teachers') {
                                                                                                    return Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        wrapWithModel(
                                                                                                          model: _model.listOfDaysLEmailModel1,
                                                                                                          updateCallback: () => setState(() {}),
                                                                                                          updateOnChange: true,
                                                                                                          child: ListOfDaysLEmailWidget(
                                                                                                            awarenessDayId: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    );
                                                                                                  } else if (FFAppState().showItem == 'whatsapp') {
                                                                                                    return Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        wrapWithModel(
                                                                                                          model: _model.listOfDaysLWhatsAppModel1,
                                                                                                          updateCallback: () => setState(() {}),
                                                                                                          updateOnChange: true,
                                                                                                          child: ListOfDaysLWhatsAppWidget(
                                                                                                            awarenessDayId: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    );
                                                                                                  } else if (FFAppState().showItem == 'blog') {
                                                                                                    return Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        wrapWithModel(
                                                                                                          model: _model.listOfDaysLBlogModel1,
                                                                                                          updateCallback: () => setState(() {}),
                                                                                                          updateOnChange: true,
                                                                                                          child: ListOfDaysLBlogWidget(
                                                                                                            awarenessDayId: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    );
                                                                                                  } else {
                                                                                                    return const Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [],
                                                                                                    );
                                                                                                  }
                                                                                                },
                                                                                              );
                                                                                            } else if ((janContainerAwarenessDaysRecord != null) == false) {
                                                                                              return Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    decoration: const BoxDecoration(),
                                                                                                    child: wrapWithModel(
                                                                                                      model: _model.emptyItemsModel1,
                                                                                                      updateCallback: () => setState(() {}),
                                                                                                      updateOnChange: true,
                                                                                                      child: EmptyItemsWidget(
                                                                                                        awarenessDocString: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            } else {
                                                                                              return Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  wrapWithModel(
                                                                                                    model: _model.emptyItemsModel2,
                                                                                                    updateCallback: () => setState(() {}),
                                                                                                    updateOnChange: true,
                                                                                                    child: EmptyItemsWidget(
                                                                                                      awarenessDocString: containerAwarenessDaysRecordList.first.reference.id,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Align(
                                                                          alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              -1.0),
                                                                          child:
                                                                              StreamBuilder<List<ActivitiesRecord>>(
                                                                            stream:
                                                                                queryActivitiesRecord(
                                                                              queryBuilder: (activitiesRecord) => activitiesRecord.where(
                                                                                'linkedAwarenessDayId',
                                                                                isEqualTo: valueOrDefault<String>(
                                                                                  janContainerAwarenessDaysRecord?.reference.id,
                                                                                  'none',
                                                                                ),
                                                                              ),
                                                                              singleRecord: true,
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              // Customize what your widget looks like when it's loading.
                                                                              if (!snapshot.hasData) {
                                                                                return const SizedBox(
                                                                                  width: 300.0,
                                                                                  height: 300.0,
                                                                                  child: ListWidget(),
                                                                                );
                                                                              }
                                                                              List<ActivitiesRecord> containerActivitiesRecordList = snapshot.data!;
                                                                              final containerActivitiesRecord = containerActivitiesRecordList.isNotEmpty ? containerActivitiesRecordList.first : null;
                                                                              return Container(
                                                                                constraints: const BoxConstraints(
                                                                                  maxWidth: 600.0,
                                                                                ),
                                                                                decoration: const BoxDecoration(),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          constraints: const BoxConstraints(
                                                                                            maxWidth: 600.0,
                                                                                          ),
                                                                                          decoration: const BoxDecoration(),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                  child: SingleChildScrollView(
                                                                                                    scrollDirection: Axis.horizontal,
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                      children: [
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  FFAppState().showItem = 'activities';
                                                                                                                  FFAppState().isSearchingActivities = false;
                                                                                                                  FFAppState().showBasket = false;
                                                                                                                  setState(() {});
                                                                                                                },
                                                                                                                child: ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.asset(
                                                                                                                    'assets/images/activityicon.png',
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  FFAppState().showItem = 'facebook';
                                                                                                                  FFAppState().showBasket = false;
                                                                                                                  setState(() {});
                                                                                                                },
                                                                                                                child: ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.asset(
                                                                                                                    'assets/images/facebook.png',
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  FFAppState().showItem = 'linkedin';
                                                                                                                  FFAppState().showBasket = false;
                                                                                                                  setState(() {});
                                                                                                                },
                                                                                                                child: ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.asset(
                                                                                                                    'assets/images/linkedin.png',
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  FFAppState().showItem = 'x';
                                                                                                                  FFAppState().showBasket = false;
                                                                                                                  setState(() {});
                                                                                                                },
                                                                                                                child: ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.asset(
                                                                                                                    'assets/images/x_icon.webp',
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  FFAppState().showItem = 'teachers';
                                                                                                                  FFAppState().showBasket = false;
                                                                                                                  setState(() {});
                                                                                                                },
                                                                                                                child: ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.asset(
                                                                                                                    'assets/images/teachers_icon.png',
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  FFAppState().showItem = 'whatsapp';
                                                                                                                  FFAppState().showBasket = false;
                                                                                                                  setState(() {});
                                                                                                                },
                                                                                                                child: ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.asset(
                                                                                                                    'assets/images/whatsapp.jpeg',
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  FFAppState().showItem = 'blog';
                                                                                                                  FFAppState().showBasket = false;
                                                                                                                  setState(() {});
                                                                                                                },
                                                                                                                child: ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.asset(
                                                                                                                    'assets/images/blof.jpeg',
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                          child: FlutterFlowIconButton(
                                                                                                            borderColor: Colors.transparent,
                                                                                                            borderRadius: 10.0,
                                                                                                            borderWidth: 1.0,
                                                                                                            buttonSize: 50.0,
                                                                                                            icon: Icon(
                                                                                                              Icons.more_time_sharp,
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              size: 40.0,
                                                                                                            ),
                                                                                                            onPressed: () async {
                                                                                                              FFAppState().showBasket = true;
                                                                                                              setState(() {});
                                                                                                              _model.moreAwareness = !_model.moreAwareness;
                                                                                                              setState(() {});
                                                                                                            },
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                if (responsiveVisibility(
                                                                                                  context: context,
                                                                                                  tabletLandscape: false,
                                                                                                  desktop: false,
                                                                                                ))
                                                                                                  SizedBox(
                                                                                                    width: 350.0,
                                                                                                    height: 250.0,
                                                                                                    child: custom_widgets.AwarenessDayCalendarMobile(
                                                                                                      width: 350.0,
                                                                                                      height: 250.0,
                                                                                                      onDateChange: () async {},
                                                                                                    ),
                                                                                                  ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Builder(
                                                                                      builder: (context) {
                                                                                        if (valueOrDefault<bool>(
                                                                                          valueOrDefault<bool>(
                                                                                                ((janContainerAwarenessDaysRecord?.linkedActivity != null && (janContainerAwarenessDaysRecord?.linkedActivity)!.isNotEmpty) == true) && (FFAppState().showItem == 'activities'),
                                                                                                false,
                                                                                              ) ||
                                                                                              valueOrDefault<bool>(
                                                                                                ((janContainerAwarenessDaysRecord?.linkedFb != null && (janContainerAwarenessDaysRecord?.linkedFb)!.isNotEmpty) == true) && (FFAppState().showItem == 'facebook'),
                                                                                                false,
                                                                                              ) ||
                                                                                              valueOrDefault<bool>(
                                                                                                ((janContainerAwarenessDaysRecord?.linkedEmail != null && (janContainerAwarenessDaysRecord?.linkedEmail)!.isNotEmpty) == true) && (FFAppState().showItem == 'teachers'),
                                                                                                false,
                                                                                              ) ||
                                                                                              valueOrDefault<bool>(
                                                                                                ((janContainerAwarenessDaysRecord?.linkedLinkedin != null && (janContainerAwarenessDaysRecord?.linkedLinkedin)!.isNotEmpty) == true) && (FFAppState().showItem == 'linkedin'),
                                                                                                false,
                                                                                              ) ||
                                                                                              valueOrDefault<bool>(
                                                                                                ((janContainerAwarenessDaysRecord?.linkedBlog != null && (janContainerAwarenessDaysRecord?.linkedBlog)!.isNotEmpty) == true) && (FFAppState().showItem == 'blog'),
                                                                                                false,
                                                                                              ) ||
                                                                                              valueOrDefault<bool>(
                                                                                                ((janContainerAwarenessDaysRecord?.linkedX != null && (janContainerAwarenessDaysRecord?.linkedX)!.isNotEmpty) == true) && (FFAppState().showItem == 'x'),
                                                                                                false,
                                                                                              ) ||
                                                                                              valueOrDefault<bool>(
                                                                                                ((janContainerAwarenessDaysRecord?.linkedWhatsapp != null && (janContainerAwarenessDaysRecord?.linkedWhatsapp)!.isNotEmpty) == true) && (FFAppState().showItem == 'whatsapp'),
                                                                                                false,
                                                                                              ),
                                                                                          false,
                                                                                        )) {
                                                                                          return Builder(
                                                                                            builder: (context) {
                                                                                              if (valueOrDefault<bool>(
                                                                                                FFAppState().showItem == 'activities',
                                                                                                true,
                                                                                              )) {
                                                                                                return Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    StreamBuilder<List<ActivitiesRecord>>(
                                                                                                      stream: queryActivitiesRecord(
                                                                                                        queryBuilder: (activitiesRecord) => activitiesRecord
                                                                                                            .where(
                                                                                                              'activityDate',
                                                                                                              isEqualTo: FFAppState().selectedDate,
                                                                                                            )
                                                                                                            .where(
                                                                                                              'linkedAwarenessDayId',
                                                                                                              isEqualTo: janContainerAwarenessDaysRecord?.reference.id,
                                                                                                            ),
                                                                                                      ),
                                                                                                      builder: (context, snapshot) {
                                                                                                        // Customize what your widget looks like when it's loading.
                                                                                                        if (!snapshot.hasData) {
                                                                                                          return const Center(
                                                                                                            child: SizedBox(
                                                                                                              width: 400.0,
                                                                                                              height: 250.0,
                                                                                                              child: ListWidget(),
                                                                                                            ),
                                                                                                          );
                                                                                                        }
                                                                                                        List<ActivitiesRecord> containerActivitiesRecordList = snapshot.data!;
                                                                                                        return Container(
                                                                                                          decoration: const BoxDecoration(),
                                                                                                          child: SingleChildScrollView(
                                                                                                            child: Column(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              children: [
                                                                                                                Container(
                                                                                                                  constraints: const BoxConstraints(
                                                                                                                    maxWidth: 800.0,
                                                                                                                  ),
                                                                                                                  decoration: const BoxDecoration(),
                                                                                                                  child: Column(
                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                    children: [
                                                                                                                      Builder(
                                                                                                                        builder: (context) {
                                                                                                                          final activitiesRow = containerActivitiesRecordList.toList();
                                                                                                                          return SingleChildScrollView(
                                                                                                                            scrollDirection: Axis.horizontal,
                                                                                                                            child: Row(
                                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                                              children: List.generate(activitiesRow.length, (activitiesRowIndex) {
                                                                                                                                final activitiesRowItem = activitiesRow[activitiesRowIndex];
                                                                                                                                return InkWell(
                                                                                                                                  splashColor: Colors.transparent,
                                                                                                                                  focusColor: Colors.transparent,
                                                                                                                                  hoverColor: Colors.transparent,
                                                                                                                                  highlightColor: Colors.transparent,
                                                                                                                                  onTap: () async {
                                                                                                                                    context.pushNamed(
                                                                                                                                      'activityDetails',
                                                                                                                                      queryParameters: {
                                                                                                                                        'activityRef': serializeParam(
                                                                                                                                          activitiesRowItem.reference,
                                                                                                                                          ParamType.DocumentReference,
                                                                                                                                        ),
                                                                                                                                        'companyDoc': serializeParam(
                                                                                                                                          containerCompaniesRecordList.first,
                                                                                                                                          ParamType.Document,
                                                                                                                                        ),
                                                                                                                                      }.withoutNulls,
                                                                                                                                      extra: <String, dynamic>{
                                                                                                                                        'companyDoc': containerCompaniesRecordList.first,
                                                                                                                                      },
                                                                                                                                    );
                                                                                                                                  },
                                                                                                                                  child: Column(
                                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                                    children: [
                                                                                                                                      Padding(
                                                                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
                                                                                                                                        child: Container(
                                                                                                                                          width: 400.0,
                                                                                                                                          constraints: const BoxConstraints(
                                                                                                                                            maxWidth: 500.0,
                                                                                                                                          ),
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                                            boxShadow: const [
                                                                                                                                              BoxShadow(
                                                                                                                                                blurRadius: 2.0,
                                                                                                                                                color: Color(0x520E151B),
                                                                                                                                                offset: Offset(
                                                                                                                                                  0.0,
                                                                                                                                                  1.0,
                                                                                                                                                ),
                                                                                                                                              )
                                                                                                                                            ],
                                                                                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                                                                                          ),
                                                                                                                                          child: Column(
                                                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                                                            children: [
                                                                                                                                              SizedBox(
                                                                                                                                                height: 300.0,
                                                                                                                                                child: Stack(
                                                                                                                                                  children: [
                                                                                                                                                    ClipRRect(
                                                                                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                                                                                      child: Image.network(
                                                                                                                                                        getCORSProxyUrl(
                                                                                                                                                          valueOrDefault<String>(
                                                                                                                                                            activitiesRowItem.activityImage,
                                                                                                                                                            'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDJ8fHByb2R1Y3RzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                                                                                        width: double.infinity,
                                                                                                                                                        height: 300.0,
                                                                                                                                                        fit: BoxFit.cover,
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                    Column(
                                                                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                      children: [
                                                                                                                                                        ClipRRect(
                                                                                                                                                          child: BackdropFilter(
                                                                                                                                                            filter: ImageFilter.blur(
                                                                                                                                                              sigmaX: 2.0,
                                                                                                                                                              sigmaY: 2.0,
                                                                                                                                                            ),
                                                                                                                                                            child: Align(
                                                                                                                                                              alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                                                                                              child: Container(
                                                                                                                                                                width: 60.0,
                                                                                                                                                                height: 100.0,
                                                                                                                                                                decoration: const BoxDecoration(
                                                                                                                                                                  borderRadius: BorderRadius.only(
                                                                                                                                                                    bottomLeft: Radius.circular(12.0),
                                                                                                                                                                    bottomRight: Radius.circular(12.0),
                                                                                                                                                                    topLeft: Radius.circular(0.0),
                                                                                                                                                                    topRight: Radius.circular(0.0),
                                                                                                                                                                  ),
                                                                                                                                                                ),
                                                                                                                                                                child: Padding(
                                                                                                                                                                  padding: const EdgeInsets.all(12.0),
                                                                                                                                                                  child: Column(
                                                                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                                    children: [
                                                                                                                                                                      Row(
                                                                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                                                                                                        children: [
                                                                                                                                                                          Container(
                                                                                                                                                                            width: 50.0,
                                                                                                                                                                            height: 50.0,
                                                                                                                                                                            decoration: const BoxDecoration(),
                                                                                                                                                                            child: Theme(
                                                                                                                                                                              data: ThemeData(
                                                                                                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                                                                                                  shape: RoundedRectangleBorder(
                                                                                                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                                                                                                  ),
                                                                                                                                                                                ),
                                                                                                                                                                                unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                                                              ),
                                                                                                                                                                              child: Checkbox(
                                                                                                                                                                                value: _model.checkboxValueMap2[activitiesRowItem] ??= containerActivitiesRecord!.isActive,
                                                                                                                                                                                onChanged: (newValue) async {
                                                                                                                                                                                  setState(() => _model.checkboxValueMap2[activitiesRowItem] = newValue!);
                                                                                                                                                                                  if (newValue!) {
                                                                                                                                                                                    await activitiesRowItem.reference.update(createActivitiesRecordData(
                                                                                                                                                                                      isActive: true,
                                                                                                                                                                                    ));
                                                                                                                                                                                  } else {
                                                                                                                                                                                    await activitiesRowItem.reference.update(createActivitiesRecordData(
                                                                                                                                                                                      isActive: false,
                                                                                                                                                                                    ));
                                                                                                                                                                                  }
                                                                                                                                                                                },
                                                                                                                                                                                side: BorderSide(
                                                                                                                                                                                  width: 2,
                                                                                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                                                                ),
                                                                                                                                                                                activeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                                                                                checkColor: FlutterFlowTheme.of(context).info,
                                                                                                                                                                              ),
                                                                                                                                                                            ),
                                                                                                                                                                          ),
                                                                                                                                                                        ],
                                                                                                                                                                      ),
                                                                                                                                                                    ],
                                                                                                                                                                  ),
                                                                                                                                                                ),
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                                                                                        ClipRRect(
                                                                                                                                                          child: BackdropFilter(
                                                                                                                                                            filter: ImageFilter.blur(
                                                                                                                                                              sigmaX: 2.0,
                                                                                                                                                              sigmaY: 2.0,
                                                                                                                                                            ),
                                                                                                                                                            child: Container(
                                                                                                                                                              width: double.infinity,
                                                                                                                                                              decoration: const BoxDecoration(
                                                                                                                                                                color: Color(0xB2FFFFFF),
                                                                                                                                                                borderRadius: BorderRadius.only(
                                                                                                                                                                  bottomLeft: Radius.circular(12.0),
                                                                                                                                                                  bottomRight: Radius.circular(12.0),
                                                                                                                                                                  topLeft: Radius.circular(0.0),
                                                                                                                                                                  topRight: Radius.circular(0.0),
                                                                                                                                                                ),
                                                                                                                                                              ),
                                                                                                                                                              child: Padding(
                                                                                                                                                                padding: const EdgeInsets.all(12.0),
                                                                                                                                                                child: Column(
                                                                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                                  children: [
                                                                                                                                                                    Row(
                                                                                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                                                      children: [
                                                                                                                                                                        Text(
                                                                                                                                                                          activitiesRowItem.activityName,
                                                                                                                                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                                                                                fontFamily: 'Readex Pro',
                                                                                                                                                                                color: const Color(0xFF0F1113),
                                                                                                                                                                                letterSpacing: 0.0,
                                                                                                                                                                              ),
                                                                                                                                                                        ),
                                                                                                                                                                        Text(
                                                                                                                                                                          activitiesRowItem.ageGroup,
                                                                                                                                                                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                                                                                                fontFamily: 'Outfit',
                                                                                                                                                                                color: const Color(0xFF0F1113),
                                                                                                                                                                                letterSpacing: 0.0,
                                                                                                                                                                              ),
                                                                                                                                                                        ),
                                                                                                                                                                      ],
                                                                                                                                                                    ),
                                                                                                                                                                    Padding(
                                                                                                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                                                                                                      child: Text(
                                                                                                                                                                        activitiesRowItem.activitySummary,
                                                                                                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                                                                              fontFamily: 'Readex Pro',
                                                                                                                                                                              letterSpacing: 0.0,
                                                                                                                                                                            ),
                                                                                                                                                                      ),
                                                                                                                                                                    ),
                                                                                                                                                                  ],
                                                                                                                                                                ),
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                                                                                      ],
                                                                                                                                                    ),
                                                                                                                                                  ],
                                                                                                                                                ),
                                                                                                                                              ),
                                                                                                                                            ],
                                                                                                                                          ),
                                                                                                                                        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!),
                                                                                                                                      ),
                                                                                                                                    ],
                                                                                                                                  ),
                                                                                                                                );
                                                                                                                              }),
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        },
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    ),
                                                                                                    Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                                                                                                          child: FFButtonWidget(
                                                                                                            onPressed: () async {
                                                                                                              await ReadyToProcessRecord.collection.doc().set(createReadyToProcessRecordData(
                                                                                                                    awarenessDayDetails: createAwarenessStruct(
                                                                                                                      awarenessDay: janContainerAwarenessDaysRecord?.reference.id,
                                                                                                                      awarenessIdString: janContainerAwarenessDaysRecord?.reference.id,
                                                                                                                      awarenessdate: janContainerAwarenessDaysRecord?.date,
                                                                                                                      clearUnsetFields: false,
                                                                                                                      create: true,
                                                                                                                    ),
                                                                                                                    jobNumber: random_data.randomString(
                                                                                                                      9,
                                                                                                                      9,
                                                                                                                      true,
                                                                                                                      false,
                                                                                                                      false,
                                                                                                                    ),
                                                                                                                    status: 'pending',
                                                                                                                    type: 'Activity Generation',
                                                                                                                    dateCreated: getCurrentTimestamp,
                                                                                                                  ));
                                                                                                              FFAppState().showBasket = true;
                                                                                                              _model.updatePage(() {});
                                                                                                            },
                                                                                                            text: 'Get Another Activity',
                                                                                                            options: FFButtonOptions(
                                                                                                              width: 160.0,
                                                                                                              height: 34.0,
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                              color: containerCompaniesRecordList.first.secondaryColor,
                                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                    fontFamily: 'Readex Pro',
                                                                                                                    color: Colors.white,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                  ),
                                                                                                              elevation: 3.0,
                                                                                                              borderSide: const BorderSide(
                                                                                                                color: Colors.transparent,
                                                                                                                width: 1.0,
                                                                                                              ),
                                                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              } else if (FFAppState().showItem == 'facebook') {
                                                                                                return Container(
                                                                                                  decoration: const BoxDecoration(),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      StreamBuilder<List<FacebookPostsRecord>>(
                                                                                                        stream: queryFacebookPostsRecord(
                                                                                                          queryBuilder: (facebookPostsRecord) => facebookPostsRecord.where(
                                                                                                            'linkedAwarenessDay',
                                                                                                            isEqualTo: janContainerAwarenessDaysRecord?.reference.id,
                                                                                                          ),
                                                                                                        ),
                                                                                                        builder: (context, snapshot) {
                                                                                                          // Customize what your widget looks like when it's loading.
                                                                                                          if (!snapshot.hasData) {
                                                                                                            return Center(
                                                                                                              child: SizedBox(
                                                                                                                width: 50.0,
                                                                                                                height: 50.0,
                                                                                                                child: CircularProgressIndicator(
                                                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                                    FlutterFlowTheme.of(context).primary,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            );
                                                                                                          }
                                                                                                          List<FacebookPostsRecord> containerFacebookPostsRecordList = snapshot.data!;
                                                                                                          return Container(
                                                                                                            decoration: const BoxDecoration(),
                                                                                                            child: Visibility(
                                                                                                              visible: FFAppState().editMode == true,
                                                                                                              child: Padding(
                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                                child: TextFormField(
                                                                                                                  controller: _model.textController2 ??= TextEditingController(
                                                                                                                    text: valueOrDefault<String>(
                                                                                                                      containerFacebookPostsRecordList.where((e) => e.dateposted == FFAppState().selectedDate).toList().first.mainText,
                                                                                                                      'maintext',
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  focusNode: _model.textFieldFocusNode2,
                                                                                                                  onChanged: (_) => EasyDebounce.debounce(
                                                                                                                    '_model.textController2',
                                                                                                                    const Duration(milliseconds: 2000),
                                                                                                                    () async {
                                                                                                                      await containerFacebookPostsRecordList.where((e) => e.dateposted == FFAppState().selectedDate).toList().first.reference.update(createFacebookPostsRecordData(
                                                                                                                            description: _model.textController2.text,
                                                                                                                          ));
                                                                                                                    },
                                                                                                                  ),
                                                                                                                  autofocus: true,
                                                                                                                  obscureText: false,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    labelText: 'Label here...',
                                                                                                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                          fontFamily: 'Readex Pro',
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                          fontFamily: 'Readex Pro',
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                    enabledBorder: UnderlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                                                        width: 2.0,
                                                                                                                      ),
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                    ),
                                                                                                                    focusedBorder: UnderlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                                        width: 2.0,
                                                                                                                      ),
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                    ),
                                                                                                                    errorBorder: UnderlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                                        width: 2.0,
                                                                                                                      ),
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                    ),
                                                                                                                    focusedErrorBorder: UnderlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                                        width: 2.0,
                                                                                                                      ),
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        fontFamily: 'Readex Pro',
                                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                  maxLines: null,
                                                                                                                  validator: _model.textController2Validator.asValidator(context),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                      ),
                                                                                                      wrapWithModel(
                                                                                                        model: _model.listOfDaysFacebookModel2,
                                                                                                        updateCallback: () => setState(() {}),
                                                                                                        updateOnChange: true,
                                                                                                        child: ListOfDaysFacebookWidget(
                                                                                                          awarenessDayId: janContainerAwarenessDaysRecord?.reference.id,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              } else if (FFAppState().showItem == 'linkedin') {
                                                                                                return SingleChildScrollView(
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      wrapWithModel(
                                                                                                        model: _model.listOfDaysLinkedinModel2,
                                                                                                        updateCallback: () => setState(() {}),
                                                                                                        child: ListOfDaysLinkedinWidget(
                                                                                                          awarenessDayId: janContainerAwarenessDaysRecord!.reference.id,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              } else if (valueOrDefault<bool>(
                                                                                                FFAppState().showItem == 'switch',
                                                                                                false,
                                                                                              )) {
                                                                                                return Builder(
                                                                                                  builder: (context) {
                                                                                                    if (valueOrDefault<bool>(
                                                                                                      containerAwarenessDaysRecordList.isNotEmpty,
                                                                                                      true,
                                                                                                    )) {
                                                                                                      return Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          wrapWithModel(
                                                                                                            model: _model.listOdDaysModel2,
                                                                                                            updateCallback: () => setState(() {}),
                                                                                                            updateOnChange: true,
                                                                                                            child: ListOdDaysWidget(
                                                                                                              listOfDaysDocsFiltered: containerAwarenessDaysRecordList,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      );
                                                                                                    } else {
                                                                                                      return Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            'You only have one to choose from, you will need to run again if you wish to see alternatives.',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Readex Pro',
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  fontSize: 20.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                ),
                                                                                                          ),
                                                                                                          Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                                                                                                                child: FFButtonWidget(
                                                                                                                  onPressed: () {
                                                                                                                    print('Button pressed ...');
                                                                                                                  },
                                                                                                                  text: 'Try For more Awareness days',
                                                                                                                  icon: const Icon(
                                                                                                                    Icons.refresh_sharp,
                                                                                                                    size: 30.0,
                                                                                                                  ),
                                                                                                                  options: FFButtonOptions(
                                                                                                                    width: 300.0,
                                                                                                                    height: 35.0,
                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                          fontFamily: 'Readex Pro',
                                                                                                                          color: Colors.white,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                    elevation: 3.0,
                                                                                                                    borderSide: const BorderSide(
                                                                                                                      color: Colors.transparent,
                                                                                                                      width: 1.0,
                                                                                                                    ),
                                                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation2']!),
                                                                                                        ],
                                                                                                      );
                                                                                                    }
                                                                                                  },
                                                                                                );
                                                                                              } else if (valueOrDefault<bool>(
                                                                                                FFAppState().showItem == 'x',
                                                                                                false,
                                                                                              )) {
                                                                                                return Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    wrapWithModel(
                                                                                                      model: _model.listOfDaysXModel2,
                                                                                                      updateCallback: () => setState(() {}),
                                                                                                      child: ListOfDaysXWidget(
                                                                                                        awarenessDayId: janContainerAwarenessDaysRecord!.reference.id,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              } else if (FFAppState().showItem == 'teachers') {
                                                                                                return Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    wrapWithModel(
                                                                                                      model: _model.listOfDaysLEmailModel2,
                                                                                                      updateCallback: () => setState(() {}),
                                                                                                      updateOnChange: true,
                                                                                                      child: ListOfDaysLEmailWidget(
                                                                                                        awarenessDayId: janContainerAwarenessDaysRecord!.reference.id,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              } else if (FFAppState().showItem == 'whatsapp') {
                                                                                                return Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    wrapWithModel(
                                                                                                      model: _model.listOfDaysLWhatsAppModel2,
                                                                                                      updateCallback: () => setState(() {}),
                                                                                                      updateOnChange: true,
                                                                                                      child: ListOfDaysLWhatsAppWidget(
                                                                                                        awarenessDayId: janContainerAwarenessDaysRecord!.reference.id,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              } else if (FFAppState().showItem == 'blog') {
                                                                                                return Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    wrapWithModel(
                                                                                                      model: _model.listOfDaysLBlogModel2,
                                                                                                      updateCallback: () => setState(() {}),
                                                                                                      updateOnChange: true,
                                                                                                      child: ListOfDaysLBlogWidget(
                                                                                                        awarenessDayId: valueOrDefault<String>(
                                                                                                          janContainerAwarenessDaysRecord?.reference.id,
                                                                                                          '-',
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              } else {
                                                                                                return const Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [],
                                                                                                );
                                                                                              }
                                                                                            },
                                                                                          );
                                                                                        } else if (valueOrDefault<bool>(
                                                                                          (janContainerAwarenessDaysRecord != null) != true,
                                                                                          false,
                                                                                        )) {
                                                                                          return Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                decoration: const BoxDecoration(),
                                                                                                child: wrapWithModel(
                                                                                                  model: _model.emptyItemsModel3,
                                                                                                  updateCallback: () => setState(() {}),
                                                                                                  updateOnChange: true,
                                                                                                  child: EmptyItemsWidget(
                                                                                                    awarenessDocString: valueOrDefault<String>(
                                                                                                      janContainerAwarenessDaysRecord?.reference.id,
                                                                                                      '1',
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        } else {
                                                                                          return Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              wrapWithModel(
                                                                                                model: _model.emptyItemsModel4,
                                                                                                updateCallback: () => setState(() {}),
                                                                                                updateOnChange: true,
                                                                                                child: EmptyItemsWidget(
                                                                                                  awarenessDocString: janContainerAwarenessDaysRecord!.reference.id,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          StreamBuilder<
                                              List<AwarenessDaysRecord>>(
                                            stream: queryAwarenessDaysRecord(
                                              queryBuilder:
                                                  (awarenessDaysRecord) =>
                                                      awarenessDaysRecord
                                                          .where(
                                                            'date',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .selectedDate,
                                                          )
                                                          .where(
                                                            'selected',
                                                            isEqualTo: true,
                                                          ),
                                              singleRecord: true,
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<AwarenessDaysRecord>
                                                  containerAwarenessDaysRecordList =
                                                  snapshot.data!;
                                              final containerAwarenessDaysRecord =
                                                  containerAwarenessDaysRecordList
                                                          .isNotEmpty
                                                      ? containerAwarenessDaysRecordList
                                                          .first
                                                      : null;
                                              return Container(
                                                constraints: const BoxConstraints(
                                                  maxWidth: 800.0,
                                                ),
                                                decoration: const BoxDecoration(),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          maxWidth: 800.0,
                                                        ),
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: StreamBuilder<
                                                              List<
                                                                  ActivitiesRecord>>(
                                                            stream:
                                                                queryActivitiesRecord(
                                                              queryBuilder:
                                                                  (activitiesRecord) =>
                                                                      activitiesRecord
                                                                          .where(
                                                                'linkedAwarenessDayId',
                                                                isEqualTo:
                                                                    containerAwarenessDaysRecord
                                                                        ?.reference
                                                                        .id,
                                                              ),
                                                              singleRecord:
                                                                  true,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return const SizedBox(
                                                                  width: 300.0,
                                                                  height: 300.0,
                                                                  child:
                                                                      ListWidget(),
                                                                );
                                                              }
                                                              List<ActivitiesRecord>
                                                                  containerActivitiesRecordList =
                                                                  snapshot
                                                                      .data!;
                                                              final containerActivitiesRecord =
                                                                  containerActivitiesRecordList
                                                                          .isNotEmpty
                                                                      ? containerActivitiesRecordList
                                                                          .first
                                                                      : null;
                                                              return Container(
                                                                decoration:
                                                                    const BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              800.0,
                                                                          decoration:
                                                                              const BoxDecoration(),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          if (FFAppState().showBasket == true)
                            Align(
                              alignment: const AlignmentDirectional(1.0, -1.0),
                              child: wrapWithModel(
                                model: _model.cartModel,
                                updateCallback: () => setState(() {}),
                                updateOnChange: true,
                                child: CartWidget(
                                  color: containerCompaniesRecordList
                                      .first.primaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
