import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/chat_window_widget.dart';
import '/components/list_widget.dart';
import '/components/login_box_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'j_t_p_diary_model.dart';
export 'j_t_p_diary_model.dart';

class JTPDiaryWidget extends StatefulWidget {
  const JTPDiaryWidget({super.key});

  @override
  State<JTPDiaryWidget> createState() => _JTPDiaryWidgetState();
}

class _JTPDiaryWidgetState extends State<JTPDiaryWidget>
    with TickerProviderStateMixin {
  late JTPDiaryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JTPDiaryModel());

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
      FFAppState().pageSelected = 'diary';
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
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
                decoration: BoxDecoration(
                  color: containerCompaniesRecordList.first.primaryColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                              color: containerCompaniesRecordList
                                  .first.primaryColor,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    wrapWithModel(
                                      model: _model.sidemenuModel,
                                      updateCallback: () => setState(() {}),
                                      updateOnChange: true,
                                      child: SidemenuWidget(
                                        companyDoc:
                                            containerCompaniesRecordList.first,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.8,
                              ),
                              decoration: const BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(19.0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              maxHeight: 150.0,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  25.0,
                                                                  0.0,
                                                                  25.0,
                                                                  0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          containerCompaniesRecordList
                                                              .first
                                                              .nameForAiChat,
                                                          'chat',
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              color: containerCompaniesRecordList
                                                                  .first
                                                                  .secondaryTextColor,
                                                              fontSize: 30.0,
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          getCORSProxyUrl(
                                            valueOrDefault<String>(
                                              containerCompaniesRecordList
                                                  .first.companyLogo,
                                              'https://picsum.photos/seed/186/600',
                                            ),
                                          ),
                                          height: 150.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.9,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
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
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
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
                                                                  Container(
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxWidth:
                                                                          MediaQuery.sizeOf(context).width *
                                                                              0.4,
                                                                    ),
                                                                    decoration:
                                                                        const BoxDecoration(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.45,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.85,
                                                                          decoration:
                                                                              const BoxDecoration(),
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.chatWindowModel,
                                                                            updateCallback: () =>
                                                                                setState(() {}),
                                                                            updateOnChange:
                                                                                true,
                                                                            child:
                                                                                ChatWindowWidget(
                                                                              companyDoc: containerCompaniesRecordList.first,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
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
                                Align(
                                  alignment: const AlignmentDirectional(0.0, -1.0),
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [],
                                                    ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      tabletLandscape: false,
                                                      desktop: false,
                                                    ))
                                                      SizedBox(
                                                        width: 350.0,
                                                        height: 250.0,
                                                        child: custom_widgets
                                                            .AwarenessDayCalendarMobile(
                                                          width: 350.0,
                                                          height: 250.0,
                                                          onDateChange:
                                                              () async {},
                                                        ),
                                                      ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        StreamBuilder<
                                                            List<
                                                                HTMLcontentRecord>>(
                                                          stream:
                                                              queryHTMLcontentRecord(
                                                            queryBuilder: (hTMLcontentRecord) =>
                                                                hTMLcontentRecord
                                                                    .where(
                                                                      'user_id',
                                                                      isEqualTo:
                                                                          currentUserReference
                                                                              ?.id,
                                                                    )
                                                                    .orderBy(
                                                                        'created_time',
                                                                        descending:
                                                                            true),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return const Center(
                                                                child:
                                                                    SizedBox(
                                                                  width: 400.0,
                                                                  height: 250.0,
                                                                  child:
                                                                      ListWidget(),
                                                                ),
                                                              );
                                                            }
                                                            List<HTMLcontentRecord>
                                                                containerHTMLcontentRecordList =
                                                                snapshot.data!;
                                                            return Container(
                                                              decoration:
                                                                  const BoxDecoration(),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      constraints:
                                                                          const BoxConstraints(
                                                                        maxWidth:
                                                                            800.0,
                                                                      ),
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Builder(
                                                                            builder:
                                                                                (context) {
                                                                              final diaryActivities = containerHTMLcontentRecordList.toList();
                                                                              if (diaryActivities.isEmpty) {
                                                                                return Image.asset(
                                                                                  'assets/images/Screenshot_2024-06-13_at_16.53.59-removebg-preview.png',
                                                                                );
                                                                              }
                                                                              return SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: List.generate(diaryActivities.length, (diaryActivitiesIndex) {
                                                                                    final diaryActivitiesItem = diaryActivities[diaryActivitiesIndex];
                                                                                    return InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        context.pushNamed(
                                                                                          'htmlContentPage',
                                                                                          queryParameters: {
                                                                                            'activityRef': serializeParam(
                                                                                              diaryActivitiesItem.reference,
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
                                                                                                              diaryActivitiesItem.imageUrl,
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
                                                                                                                              diaryActivitiesItem.title,
                                                                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                                    fontFamily: 'Readex Pro',
                                                                                                                                    color: const Color(0xFF0F1113),
                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                  ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                        Padding(
                                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                                                          child: Text(
                                                                                                                            diaryActivitiesItem.summary,
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
