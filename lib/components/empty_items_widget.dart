import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'empty_items_model.dart';
export 'empty_items_model.dart';

class EmptyItemsWidget extends StatefulWidget {
  const EmptyItemsWidget({
    super.key,
    required this.awarenessDocString,
  });

  final String? awarenessDocString;

  @override
  State<EmptyItemsWidget> createState() => _EmptyItemsWidgetState();
}

class _EmptyItemsWidgetState extends State<EmptyItemsWidget> {
  late EmptyItemsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyItemsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<AwarenessDaysRecord>>(
      stream: queryAwarenessDaysRecord(
        queryBuilder: (awarenessDaysRecord) => awarenessDaysRecord.where(
          'documentId',
          isEqualTo: widget.awarenessDocString,
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
        List<AwarenessDaysRecord> containerAwarenessDaysRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final containerAwarenessDaysRecord =
            containerAwarenessDaysRecordList.isNotEmpty
                ? containerAwarenessDaysRecordList.first
                : null;
        return Container(
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                StreamBuilder<List<ActivitiesRecord>>(
                  stream: queryActivitiesRecord(
                    queryBuilder: (activitiesRecord) => activitiesRecord.where(
                      'linkedAwarenessDayId',
                      isEqualTo: containerAwarenessDaysRecord?.reference.id,
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
                    List<ActivitiesRecord> containerActivitiesRecordList =
                        snapshot.data!;
                    return Container(
                      decoration: const BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          if (valueOrDefault<bool>(
                            ((containerActivitiesRecordList.isNotEmpty) !=
                                    true) &&
                                valueOrDefault<bool>(
                                  FFAppState().isSearchingActivities != true,
                                  false,
                                ),
                            false,
                          )) {
                            return Visibility(
                              visible: valueOrDefault<bool>(
                                ((containerAwarenessDaysRecord
                                                    ?.linkedActivity !=
                                                null &&
                                            (containerAwarenessDaysRecord
                                                    ?.linkedActivity)!
                                                .isNotEmpty) !=
                                        true) &&
                                    valueOrDefault<bool>(
                                      FFAppState().showItem == 'activities',
                                      false,
                                    ),
                                false,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/activityicon.png',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 0.0),
                                    child: Text(
                                      'No Activity',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            fontFamily: 'Outfit',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 8.0),
                                      child: Text(
                                        'You do not yet have an activity post for today? would you like to generate one now? ',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 16.0, 16.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _model.selectedcoFb =
                                            await queryCompaniesRecordOnce(
                                          queryBuilder: (companiesRecord) =>
                                              companiesRecord.where(
                                            'companyId',
                                            isEqualTo:
                                                FFAppState().selectedCompanyId,
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);

                                        await ReadyToProcessRecord.collection
                                            .doc()
                                            .set(createReadyToProcessRecordData(
                                              awarenessDayDetails:
                                                  createAwarenessStruct(
                                                awarenessDay:
                                                    containerAwarenessDaysRecord
                                                        ?.item,
                                                awarenessIdString:
                                                    containerAwarenessDaysRecord
                                                        ?.reference.id,
                                                awarenessdate:
                                                    containerAwarenessDaysRecord
                                                        ?.date,
                                                clearUnsetFields: false,
                                                create: true,
                                              ),
                                              jobNumber:
                                                  random_data.randomString(
                                                9,
                                                9,
                                                true,
                                                false,
                                                false,
                                              ),
                                              status: 'pending',
                                              type: 'Activity Generation',
                                              dateCreated: getCurrentTimestamp,
                                              companyOwner: FFAppState()
                                                  .selectedCompanyId,
                                              companyName: _model
                                                  .selectedcoFb?.companyName,
                                            ));
                                        FFAppState().isSearchingActivities =
                                            true;
                                        FFAppState().showBasket = true;
                                        _model.updatePage(() {});

                                        setState(() {});
                                      },
                                      text: 'Get Activity',
                                      options: FFButtonOptions(
                                        width: 200.0,
                                        height: 34.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (valueOrDefault<bool>(
                            valueOrDefault<bool>(
                                  (containerActivitiesRecordList.isNotEmpty) !=
                                      true,
                                  true,
                                ) &&
                                valueOrDefault<bool>(
                                  FFAppState().isSearchingActivities == true,
                                  false,
                                ),
                            false,
                          )) {
                            return Container(
                              width: 260.0,
                              height: 260.0,
                              decoration: const BoxDecoration(),
                              child: Lottie.asset(
                                'assets/lottie_animations/Animation_-_1717067506219.json',
                                width: 260.0,
                                height: 260.0,
                                fit: BoxFit.cover,
                                animate: true,
                              ),
                            );
                          } else {
                            return const Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [],
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
                if (valueOrDefault<bool>(
                  ((containerAwarenessDaysRecord?.linkedFb != null &&
                              (containerAwarenessDaysRecord?.linkedFb)!
                                  .isNotEmpty) !=
                          true) &&
                      (FFAppState().showItem == 'facebook'),
                  false,
                ))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/facebook.png',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'No Activity',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 4.0, 8.0, 8.0),
                          child: Text(
                            'You do not yet have a Facebook post for ${containerAwarenessDaysRecord?.item} would you like to generate one now? ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.selectedcoFb2 =
                                await queryCompaniesRecordOnce(
                              queryBuilder: (companiesRecord) =>
                                  companiesRecord.where(
                                'companyId',
                                isEqualTo: FFAppState().selectedCompanyId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);

                            await ReadyToProcessRecord.collection
                                .doc()
                                .set(createReadyToProcessRecordData(
                                  awarenessDayDetails: createAwarenessStruct(
                                    awarenessDay: valueOrDefault<String>(
                                      containerAwarenessDaysRecord?.item,
                                      'none',
                                    ),
                                    awarenessIdString: valueOrDefault<String>(
                                      containerAwarenessDaysRecord
                                          ?.reference.id,
                                      'gggg',
                                    ),
                                    awarenessdate:
                                        containerAwarenessDaysRecord?.date,
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
                                  type: 'Facebook Post Generation',
                                  dateCreated: getCurrentTimestamp,
                                  companyOwner: FFAppState().selectedCompanyId,
                                  companyName:
                                      _model.selectedcoFb2?.companyName,
                                ));
                            FFAppState().showBasket = true;
                            _model.updatePage(() {});

                            setState(() {});
                          },
                          text: 'Get Facebook Post',
                          options: FFButtonOptions(
                            width: 200.0,
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
                if (valueOrDefault<bool>(
                  ((containerAwarenessDaysRecord?.linkedLinkedin != null &&
                              (containerAwarenessDaysRecord?.linkedLinkedin)!
                                  .isNotEmpty) !=
                          true) &&
                      (FFAppState().showItem == 'linkedin'),
                  false,
                ))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/linkedin.png',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'No Activity',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 4.0, 8.0, 8.0),
                          child: Text(
                            'You do not yet have a Linkedin post for ${containerAwarenessDaysRecord?.item} would you like to generate one now? ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.selectedcoli =
                                await queryCompaniesRecordOnce(
                              queryBuilder: (companiesRecord) =>
                                  companiesRecord.where(
                                'companyId',
                                isEqualTo: FFAppState().selectedCompanyId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);

                            await ReadyToProcessRecord.collection
                                .doc()
                                .set(createReadyToProcessRecordData(
                                  awarenessDayDetails: createAwarenessStruct(
                                    awarenessDay: valueOrDefault<String>(
                                      containerAwarenessDaysRecord?.item,
                                      'none',
                                    ),
                                    awarenessIdString: valueOrDefault<String>(
                                      containerAwarenessDaysRecord
                                          ?.reference.id,
                                      'gggg',
                                    ),
                                    awarenessdate:
                                        containerAwarenessDaysRecord?.date,
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
                                  type: 'LinkedIn Post Generation',
                                  dateCreated: getCurrentTimestamp,
                                  companyOwner: FFAppState().selectedCompanyId,
                                  companyName: _model.selectedcoli?.companyName,
                                ));
                            FFAppState().showBasket = true;
                            _model.updatePage(() {});

                            setState(() {});
                          },
                          text: 'Get linkedIn Post',
                          options: FFButtonOptions(
                            width: 200.0,
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
                if (valueOrDefault<bool>(
                  ((containerAwarenessDaysRecord?.linkedEmail != null &&
                              (containerAwarenessDaysRecord?.linkedEmail)!
                                  .isNotEmpty) !=
                          true) &&
                      (FFAppState().showItem == 'teachers'),
                  false,
                ))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/teachers_icon.png',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'No Activity',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 4.0, 8.0, 8.0),
                          child: Text(
                            'You do not yet have a Teachers Email  for ${containerAwarenessDaysRecord?.item} would you like to generate one now? ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.selectedcoteacher =
                                await queryCompaniesRecordOnce(
                              queryBuilder: (companiesRecord) =>
                                  companiesRecord.where(
                                'companyId',
                                isEqualTo: FFAppState().selectedCompanyId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);

                            await ReadyToProcessRecord.collection
                                .doc()
                                .set(createReadyToProcessRecordData(
                                  awarenessDayDetails: createAwarenessStruct(
                                    awarenessDay: valueOrDefault<String>(
                                      containerAwarenessDaysRecord?.item,
                                      'none',
                                    ),
                                    awarenessIdString: valueOrDefault<String>(
                                      containerAwarenessDaysRecord
                                          ?.reference.id,
                                      'gggg',
                                    ),
                                    awarenessdate:
                                        containerAwarenessDaysRecord?.date,
                                    clearUnsetFields: false,
                                    create: true,
                                  ),
                                  jobNumber: '11122233',
                                  status: 'pending',
                                  type: 'Email Generation',
                                  dateCreated: getCurrentTimestamp,
                                  companyOwner: FFAppState().selectedCompanyId,
                                  companyName:
                                      _model.selectedcoteacher?.companyName,
                                ));
                            FFAppState().showBasket = true;
                            _model.updatePage(() {});

                            setState(() {});
                          },
                          text: 'Get Teachers Email ',
                          options: FFButtonOptions(
                            width: 200.0,
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
                if (valueOrDefault<bool>(
                  ((containerAwarenessDaysRecord?.linkedBlog != null &&
                              (containerAwarenessDaysRecord?.linkedBlog)!
                                  .isNotEmpty) !=
                          true) &&
                      (FFAppState().showItem == 'blog'),
                  false,
                ))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/blof.jpeg',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'No Activity',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 4.0, 8.0, 8.0),
                          child: Text(
                            'You do not yet have a Blog post for ${containerAwarenessDaysRecord?.item} would you like to generate one now? ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.selectedcoblog =
                                await queryCompaniesRecordOnce(
                              queryBuilder: (companiesRecord) =>
                                  companiesRecord.where(
                                'companyId',
                                isEqualTo: FFAppState().selectedCompanyId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);

                            await ReadyToProcessRecord.collection
                                .doc()
                                .set(createReadyToProcessRecordData(
                                  awarenessDayDetails: createAwarenessStruct(
                                    awarenessDay: valueOrDefault<String>(
                                      containerAwarenessDaysRecord?.item,
                                      'none',
                                    ),
                                    awarenessIdString: valueOrDefault<String>(
                                      containerAwarenessDaysRecord
                                          ?.reference.id,
                                      'gggg',
                                    ),
                                    awarenessdate:
                                        containerAwarenessDaysRecord?.date,
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
                                  type: 'Blog Generation',
                                  dateCreated: getCurrentTimestamp,
                                  companyOwner: FFAppState().selectedCompanyId,
                                  companyName:
                                      _model.selectedcoblog?.companyName,
                                ));
                            FFAppState().showBasket = true;
                            _model.updatePage(() {});

                            setState(() {});
                          },
                          text: 'Get a blog',
                          options: FFButtonOptions(
                            width: 200.0,
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
                if (valueOrDefault<bool>(
                  ((containerAwarenessDaysRecord?.linkedWhatsapp != null &&
                              (containerAwarenessDaysRecord?.linkedWhatsapp)!
                                  .isNotEmpty) !=
                          true) &&
                      valueOrDefault<bool>(
                        ((containerAwarenessDaysRecord?.linkedWhatsapp !=
                                        null &&
                                    (containerAwarenessDaysRecord
                                            ?.linkedWhatsapp)!
                                        .isNotEmpty) !=
                                true) &&
                            valueOrDefault<bool>(
                              FFAppState().showItem == 'whatsapp',
                              false,
                            ),
                        false,
                      ),
                  false,
                ))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/whatsapp.jpeg',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'No Activity',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 4.0, 8.0, 8.0),
                          child: Text(
                            'You do not yet have a Whatsapp  for ${containerAwarenessDaysRecord?.item} would you like to generate one now? ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.selectedcowa =
                                await queryCompaniesRecordOnce(
                              queryBuilder: (companiesRecord) =>
                                  companiesRecord.where(
                                'companyId',
                                isEqualTo: FFAppState().selectedCompanyId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);

                            await ReadyToProcessRecord.collection
                                .doc()
                                .set(createReadyToProcessRecordData(
                                  awarenessDayDetails: createAwarenessStruct(
                                    awarenessDay: valueOrDefault<String>(
                                      containerAwarenessDaysRecord?.item,
                                      'none',
                                    ),
                                    awarenessIdString: valueOrDefault<String>(
                                      containerAwarenessDaysRecord
                                          ?.reference.id,
                                      'gggg',
                                    ),
                                    awarenessdate:
                                        containerAwarenessDaysRecord?.date,
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
                                  type: 'Whatsapp Generation',
                                  dateCreated: getCurrentTimestamp,
                                  companyOwner: FFAppState().selectedCompanyId,
                                  companyName: _model.selectedcowa?.companyName,
                                ));
                            FFAppState().showBasket = true;
                            _model.updatePage(() {});

                            setState(() {});
                          },
                          text: 'Get Whatsapp Post',
                          options: FFButtonOptions(
                            width: 200.0,
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
                if (valueOrDefault<bool>(
                  ((containerAwarenessDaysRecord?.linkedX != null &&
                              (containerAwarenessDaysRecord?.linkedX)!
                                  .isNotEmpty) !=
                          true) &&
                      valueOrDefault<bool>(
                        FFAppState().showItem == 'x',
                        false,
                      ),
                  false,
                ))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/x_icon.webp',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'No Activity',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 4.0, 8.0, 8.0),
                          child: Text(
                            'You do not yet have a X post for ${containerAwarenessDaysRecord?.item} would you like to generate one now? ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.selectedcoc = await queryCompaniesRecordOnce(
                              queryBuilder: (companiesRecord) =>
                                  companiesRecord.where(
                                'companyId',
                                isEqualTo: FFAppState().selectedCompanyId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);

                            await ReadyToProcessRecord.collection
                                .doc()
                                .set(createReadyToProcessRecordData(
                                  awarenessDayDetails: createAwarenessStruct(
                                    awarenessDay:
                                        containerAwarenessDaysRecord?.item,
                                    awarenessIdString:
                                        containerAwarenessDaysRecord
                                            ?.reference.id,
                                    awarenessdate:
                                        containerAwarenessDaysRecord?.date,
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
                                  type: 'X Generation',
                                  dateCreated: getCurrentTimestamp,
                                  companyOwner: FFAppState().selectedCompanyId,
                                  companyName: _model.selectedcoc?.companyName,
                                ));
                            FFAppState().showBasket = true;
                            _model.updatePage(() {});

                            setState(() {});
                          },
                          text: 'Get X ',
                          options: FFButtonOptions(
                            width: 200.0,
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
            ),
          ),
        );
      },
    );
  }
}
