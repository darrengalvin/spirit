import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_od_days_full_model.dart';
export 'list_od_days_full_model.dart';

class ListOdDaysFullWidget extends StatefulWidget {
  const ListOdDaysFullWidget({
    super.key,
    this.listOfDaysDocsFiltered,
  });

  final List<AwarenessDaysRecord>? listOfDaysDocsFiltered;

  @override
  State<ListOdDaysFullWidget> createState() => _ListOdDaysFullWidgetState();
}

class _ListOdDaysFullWidgetState extends State<ListOdDaysFullWidget> {
  late ListOdDaysFullModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListOdDaysFullModel());

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

    return Container(
      width: 800.0,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 1.0),
              child: StreamBuilder<List<AwarenessDaysRecord>>(
                stream: queryAwarenessDaysRecord(),
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
                  return Container(
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          offset: const Offset(
                            0.0,
                            1.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: Builder(
                      builder: (context) {
                        final awarenessDays = containerAwarenessDaysRecordList
                            .where((e) =>
                                functions.getMonthOnly(e.date) ==
                                functions
                                    .getMonthOnly(FFAppState().selectedDate))
                            .toList();
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(awarenessDays.length,
                              (awarenessDaysIndex) {
                            final awarenessDaysItem =
                                awarenessDays[awarenessDaysIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                FFAppState().selectedAwarenessDay =
                                    valueOrDefault<String>(
                                  awarenessDaysItem.reference.id,
                                  '1',
                                );
                                setState(() {});
                                var confirmDialogResponse = await showDialog<
                                        bool>(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title:
                                              const Text('You can only have one'),
                                          content: Text(
                                              'Do you want me to remove  ${valueOrDefault<String>(
                                            containerAwarenessDaysRecordList
                                                .where(
                                                    (e) => e.selected == true)
                                                .toList()
                                                .first
                                                .item,
                                            '1',
                                          )}'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext, false),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext, true),
                                              child: const Text('Confirm'),
                                            ),
                                          ],
                                        );
                                      },
                                    ) ??
                                    false;
                                if (confirmDialogResponse) {
                                  await containerAwarenessDaysRecordList
                                      .where((e) => e.selected == true)
                                      .toList()
                                      .first
                                      .reference
                                      .update(createAwarenessDaysRecordData(
                                        selected: false,
                                      ));

                                  await awarenessDaysItem.reference
                                      .update(createAwarenessDaysRecordData(
                                    selected: true,
                                  ));
                                }
                              
                                _model.updatePage(() {});
                              },
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 4.0, 8.0, 4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    50.0,
                                                                    6.0),
                                                        child: SelectionArea(
                                                            child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                'MMMMEEEEd',
                                                                awarenessDaysItem
                                                                    .date),
                                                            'item',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    6.0),
                                                        child: SelectionArea(
                                                            child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            awarenessDaysItem
                                                                .item,
                                                            'item',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    25.0,
                                                                    0.0,
                                                                    25.0,
                                                                    6.0),
                                                        child: SelectionArea(
                                                            child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            awarenessDaysItem
                                                                .selected
                                                                .toString(),
                                                            'selected',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                  if (_model.showSource)
                                                    Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                        maxWidth: 310.0,
                                                      ),
                                                      decoration:
                                                          const BoxDecoration(),
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: SelectionArea(
                                                          child: Text(
                                                        valueOrDefault<String>(
                                                          awarenessDaysItem
                                                              .source,
                                                          'source',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      )),
                                                    ),
                                                ],
                                              ),
                                              const Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [],
                                              ),
                                              if (awarenessDaysItem.selected !=
                                                  true)
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 16.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      FFAppState()
                                                              .selectedAwarenessDay =
                                                          valueOrDefault<
                                                              String>(
                                                        awarenessDaysItem
                                                            .reference.id,
                                                        '1',
                                                      );
                                                      setState(() {});
                                                      var confirmDialogResponse =
                                                          await showDialog<
                                                                  bool>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'You can only have one'),
                                                                    content: Text(
                                                                        'Do you want me to remove  ${valueOrDefault<String>(
                                                                      containerAwarenessDaysRecordList
                                                                          .where((e) =>
                                                                              e.selected ==
                                                                              true)
                                                                          .toList()
                                                                          .first
                                                                          .item,
                                                                      '1',
                                                                    )}'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child:
                                                                            const Text('Cancel'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                        child:
                                                                            const Text('Confirm'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ) ??
                                                              false;
                                                      if (confirmDialogResponse) {
                                                        await containerAwarenessDaysRecordList
                                                            .where((e) =>
                                                                e.selected ==
                                                                true)
                                                            .toList()
                                                            .first
                                                            .reference
                                                            .update(
                                                                createAwarenessDaysRecordData(
                                                              selected: false,
                                                            ));

                                                        await awarenessDaysItem
                                                            .reference
                                                            .update(
                                                                createAwarenessDaysRecordData(
                                                          selected: true,
                                                        ));
                                                      }
                                                    
                                                      _model.updatePage(() {});
                                                    },
                                                    text: 'switch',
                                                    options: FFButtonOptions(
                                                      width: 60.0,
                                                      height: 34.0,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: const BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                  ),
                                                ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 16.0, 0.0, 16.0),
                                                child: FFButtonWidget(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  text: 'Get Activity',
                                                  options: FFButtonOptions(
                                                    width: 160.0,
                                                    height: 34.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    elevation: 3.0,
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
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
    );
  }
}
