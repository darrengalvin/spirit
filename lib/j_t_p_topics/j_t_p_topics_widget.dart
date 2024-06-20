import '/backend/backend.dart';
import '/components/empty_items_widget.dart';
import '/components/list_od_days_widget.dart';
import '/components/list_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/list_views/list_of_days_facebook/list_of_days_facebook_widget.dart';
import '/pages/list_views/list_of_days_linkedin/list_of_days_linkedin_widget.dart';
import '/pages/list_views/list_of_days_x/list_of_days_x_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'j_t_p_topics_model.dart';
export 'j_t_p_topics_model.dart';

class JTPTopicsWidget extends StatefulWidget {
  const JTPTopicsWidget({super.key});

  @override
  State<JTPTopicsWidget> createState() => _JTPTopicsWidgetState();
}

class _JTPTopicsWidgetState extends State<JTPTopicsWidget>
    with TickerProviderStateMixin {
  late JTPTopicsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JTPTopicsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().selectedDate == null) {
        FFAppState().selectedDate =
            functions.getDayAndMonth(getCurrentTimestamp);
        setState(() {});
      }
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
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
      'rowOnPageLoadAnimation': AnimationInfo(
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
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
                  width: 200.0,
                  decoration: const BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.sidemenuModel,
                    updateCallback: () => setState(() {}),
                    child: const SidemenuWidget(),
                  ),
                ),
              Expanded(
                child: StreamBuilder<List<CompaniesRecord>>(
                  stream: queryCompaniesRecord(
                    queryBuilder: (companiesRecord) => companiesRecord.where(
                      'companyId',
                      isEqualTo: FFAppState().selectedCompanyId,
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
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final containerCompaniesRecord =
                        containerCompaniesRecordList.isNotEmpty
                            ? containerCompaniesRecordList.first
                            : null;
                    return Container(
                      decoration: const BoxDecoration(),
                      child: StreamBuilder<List<AwarenessDaysRecord>>(
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
                              containerAwarenessDaysRecordList = snapshot.data!;
                          return Container(
                            decoration: const BoxDecoration(),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 15.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    constraints: const BoxConstraints(
                                                      maxWidth: 800.0,
                                                    ),
                                                    decoration: const BoxDecoration(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 150.0,
                                                  child: custom_widgets
                                                      .DatePickerTimelineWidget(
                                                    width: double.infinity,
                                                    height: 150.0,
                                                    initialDate: FFAppState()
                                                            .selectedDate ?? getCurrentTimestamp,
                                                    selectedDate: FFAppState()
                                                        .selectedDate,
                                                    maxWidth: 800,
                                                    onDateChange: () async {
                                                      _model.onDateChangeIndex =
                                                          await queryAwarenessDaysRecordOnce(
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
                                                                      isEqualTo:
                                                                          true,
                                                                    ),
                                                      );
                                                      if ((_model.onDateChangeIndex !=
                                                                  null &&
                                                              (_model.onDateChangeIndex)!
                                                                  .isNotEmpty) !=
                                                          true) {
                                                        _model.onDateChangeIndexNotSingle =
                                                            await queryAwarenessDaysRecordOnce(
                                                          queryBuilder:
                                                              (awarenessDaysRecord) =>
                                                                  awarenessDaysRecord
                                                                      .where(
                                                            'date',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .selectedDate,
                                                          ),
                                                        );

                                                        await _model
                                                            .onDateChangeIndexNotSingle!
                                                            .first
                                                            .reference
                                                            .update(
                                                                createAwarenessDaysRecordData(
                                                          selected: true,
                                                        ));
                                                      }

                                                      setState(() {});

                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    StreamBuilder<List<AwarenessDaysRecord>>(
                                      stream: queryAwarenessDaysRecord(
                                        queryBuilder: (awarenessDaysRecord) =>
                                            awarenessDaysRecord
                                                .where(
                                                  'date',
                                                  isEqualTo:
                                                      FFAppState().selectedDate,
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
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
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
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  constraints: const BoxConstraints(
                                                    maxWidth: 800.0,
                                                  ),
                                                  decoration: const BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: StreamBuilder<
                                                        List<ActivitiesRecord>>(
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
                                                        List<ActivitiesRecord>
                                                            containerActivitiesRecordList =
                                                            snapshot.data!;
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
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      FFAppState().showItem = 'activities';
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
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  InkWell(
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
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  InkWell(
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
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  InkWell(
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
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  InkWell(
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
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    child: Image.asset(
                                                                                      'assets/images/whatsapp.jpeg',
                                                                                      width: 50.0,
                                                                                      height: 50.0,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  InkWell(
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
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  if (valueOrDefault<
                                                                      bool>(
                                                                    (containerActivitiesRecord !=
                                                                            null) ==
                                                                        true,
                                                                    false,
                                                                  )) {
                                                                    return Builder(
                                                                      builder:
                                                                          (context) {
                                                                        if (valueOrDefault<
                                                                            bool>(
                                                                          FFAppState().showItem ==
                                                                              'activities',
                                                                          true,
                                                                        )) {
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
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
                                                                                        isEqualTo: containerAwarenessDaysRecord?.reference.id,
                                                                                      )
                                                                                      .where(
                                                                                        'isActive',
                                                                                        isEqualTo: true,
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
                                                                                                    final activitiesRow = containerActivitiesRecordList
                                                                                                        .where((e) => valueOrDefault<bool>(
                                                                                                              e.isActive == true,
                                                                                                              false,
                                                                                                            ))
                                                                                                        .toList();
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
                                                                                                                    containerCompaniesRecord,
                                                                                                                    ParamType.Document,
                                                                                                                  ),
                                                                                                                }.withoutNulls,
                                                                                                                extra: <String, dynamic>{
                                                                                                                  'companyDoc': containerCompaniesRecord,
                                                                                                                },
                                                                                                              );
                                                                                                            },
                                                                                                            child: Column(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              children: [
                                                                                                                Padding(
                                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
                                                                                                                  child: Container(
                                                                                                                    width: 500.0,
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
                                                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                children: [
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
                                                                                                                  ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
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
                                                                            ],
                                                                          );
                                                                        } else if (FFAppState().showItem ==
                                                                            'facebook') {
                                                                          return Container(
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                wrapWithModel(
                                                                                  model: _model.listOfDaysFacebookModel,
                                                                                  updateCallback: () => setState(() {}),
                                                                                  updateOnChange: true,
                                                                                  child: ListOfDaysFacebookWidget(
                                                                                    awarenessDayId: containerAwarenessDaysRecord?.reference.id,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 16.0, 275.0),
                                                                                  child: FFButtonWidget(
                                                                                    onPressed: () {
                                                                                      print('Button pressed ...');
                                                                                    },
                                                                                    text: 'Get A  Facebook Post',
                                                                                    options: FFButtonOptions(
                                                                                      width: 200.0,
                                                                                      height: 34.0,
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
                                                                            ),
                                                                          );
                                                                        } else if (FFAppState().showItem ==
                                                                            'linkedin') {
                                                                          return SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                wrapWithModel(
                                                                                  model: _model.listOfDaysLinkedinModel,
                                                                                  updateCallback: () => setState(() {}),
                                                                                  child: ListOfDaysLinkedinWidget(
                                                                                    awarenessDayId: containerAwarenessDaysRecord!.reference.id,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 16.0, 275.0),
                                                                                  child: FFButtonWidget(
                                                                                    onPressed: () {
                                                                                      print('Button pressed ...');
                                                                                    },
                                                                                    text: 'Get A  LinkedInPost Post',
                                                                                    options: FFButtonOptions(
                                                                                      width: 200.0,
                                                                                      height: 34.0,
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
                                                                            ),
                                                                          );
                                                                        } else if (valueOrDefault<
                                                                            bool>(
                                                                          FFAppState().showItem ==
                                                                              'switch',
                                                                          false,
                                                                        )) {
                                                                          return Builder(
                                                                            builder:
                                                                                (context) {
                                                                              if (valueOrDefault<bool>(
                                                                                containerAwarenessDaysRecordList.isNotEmpty,
                                                                                true,
                                                                              )) {
                                                                                return Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    wrapWithModel(
                                                                                      model: _model.listOdDaysModel,
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
                                                                                    ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
                                                                                  ],
                                                                                );
                                                                              }
                                                                            },
                                                                          );
                                                                        } else if (valueOrDefault<
                                                                            bool>(
                                                                          FFAppState().showItem ==
                                                                              'X',
                                                                          false,
                                                                        )) {
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              wrapWithModel(
                                                                                model: _model.listOfDaysXModel,
                                                                                updateCallback: () => setState(() {}),
                                                                                child: ListOfDaysXWidget(
                                                                                  awarenessDayId: containerAwarenessDaysRecord!.reference.id,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        } else if (containerAwarenessDaysRecord!.linkedActivity.isEmpty) {
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              const Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [],
                                                                              ),
                                                                              wrapWithModel(
                                                                                model: _model.emptyItemsModel1,
                                                                                updateCallback: () => setState(() {}),
                                                                                updateOnChange: true,
                                                                                child: EmptyItemsWidget(
                                                                                  awarenessDocString: containerAwarenessDaysRecord.reference.id,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        } else {
                                                                          return const Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [],
                                                                          );
                                                                        }
                                                                      },
                                                                    );
                                                                  } else if (valueOrDefault<
                                                                      bool>(
                                                                    (containerActivitiesRecord !=
                                                                            null) !=
                                                                        true,
                                                                    false,
                                                                  )) {
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              45.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'Todays Theme is  ',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          decoration:
                                                                              const BoxDecoration(),
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.emptyItemsModel2,
                                                                            updateCallback: () =>
                                                                                setState(() {}),
                                                                            updateOnChange:
                                                                                true,
                                                                            child:
                                                                                EmptyItemsWidget(
                                                                              awarenessDocString: valueOrDefault<String>(
                                                                                containerAwarenessDaysRecord?.reference.id,
                                                                                'vv',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    return const Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [],
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
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
