import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/empty_items_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_of_days_facebook_model.dart';
export 'list_of_days_facebook_model.dart';

class ListOfDaysFacebookWidget extends StatefulWidget {
  const ListOfDaysFacebookWidget({
    super.key,
    String? awarenessDayId,
  }) : awarenessDayId = awarenessDayId ?? '-';

  final String awarenessDayId;

  @override
  State<ListOfDaysFacebookWidget> createState() =>
      _ListOfDaysFacebookWidgetState();
}

class _ListOfDaysFacebookWidgetState extends State<ListOfDaysFacebookWidget> {
  late ListOfDaysFacebookModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListOfDaysFacebookModel());

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

    return StreamBuilder<List<FacebookPostsRecord>>(
      stream: queryFacebookPostsRecord(
        queryBuilder: (facebookPostsRecord) => facebookPostsRecord
            .where(
              'linkedAwarenessDay',
              isEqualTo: widget.awarenessDayId,
            )
            .where(
              'associatedCompanyId',
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
        List<FacebookPostsRecord> containerFacebookPostsRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final containerFacebookPostsRecord =
            containerFacebookPostsRecordList.isNotEmpty
                ? containerFacebookPostsRecordList.first
                : null;
        return Container(
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Builder(
                  builder: (context) {
                    if ((containerFacebookPostsRecord != null) == true) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 10.0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Post to Facebook',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
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
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 10.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      allowPhoto: true,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        setState(() {});
                                        return;
                                      }
                                    }

                                    await containerFacebookPostsRecord!
                                        .reference
                                        .update(createFacebookPostsRecordData(
                                      image: _model.uploadedFileUrl,
                                    ));

                                    setState(() {});
                                  },
                                  text: 'Change image',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
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
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                100.0, 0.0, 100.0, 0.0),
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 800.0,
                              ),
                              decoration: const BoxDecoration(),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: SizedBox(
                                    width: 500.0,
                                    height: 500.0,
                                    child: custom_widgets.FacebookTemplate(
                                      width: 500.0,
                                      height: 500.0,
                                      profilePicUrl:
                                          'https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png',
                                      username: FFAppState().fbUserName,
                                      timestamp: dateTimeFormat(
                                          'MMMMEEEEd', getCurrentTimestamp),
                                      content: valueOrDefault<String>(
                                        containerFacebookPostsRecord?.mainText,
                                        'main',
                                      ),
                                      mediaUrl:
                                          containerFacebookPostsRecord?.image,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 16.0, 16.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.awarenessDate =
                                    await queryAwarenessDaysRecordOnce(
                                  queryBuilder: (awarenessDaysRecord) =>
                                      awarenessDaysRecord.where(
                                    'documentId',
                                    isEqualTo: widget.awarenessDayId,
                                  ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'You will need to delete this one first'),
                                              content: const Text('Are you sure? '),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          true),
                                                  child: const Text('Confirm'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                if (confirmDialogResponse) {
                                  await containerFacebookPostsRecord!.reference
                                      .delete();

                                  await ReadyToProcessRecord.collection
                                      .doc()
                                      .set(createReadyToProcessRecordData(
                                        awarenessDayDetails:
                                            createAwarenessStruct(
                                          awarenessDay: valueOrDefault<String>(
                                            _model.awarenessDate?.item,
                                            '-',
                                          ),
                                          awarenessIdString: _model
                                              .awarenessDate?.reference.id,
                                          awarenessdate:
                                              _model.awarenessDate?.date,
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
                                      ));
                                  FFAppState().showBasket = true;
                                  _model.updatePage(() {});
                                }

                                setState(() {});
                              },
                              text: 'Get Another Facebook Post',
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
                      );
                    } else {
                      return Container(
                        decoration: const BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.emptyItemsModel,
                          updateCallback: () => setState(() {}),
                          updateOnChange: true,
                          child: EmptyItemsWidget(
                            awarenessDocString: widget.awarenessDayId,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
