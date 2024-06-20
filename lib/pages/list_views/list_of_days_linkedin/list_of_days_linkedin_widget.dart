import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_of_days_linkedin_model.dart';
export 'list_of_days_linkedin_model.dart';

class ListOfDaysLinkedinWidget extends StatefulWidget {
  const ListOfDaysLinkedinWidget({
    super.key,
    String? awarenessDayId,
  }) : awarenessDayId = awarenessDayId ?? '-';

  final String awarenessDayId;

  @override
  State<ListOfDaysLinkedinWidget> createState() =>
      _ListOfDaysLinkedinWidgetState();
}

class _ListOfDaysLinkedinWidgetState extends State<ListOfDaysLinkedinWidget> {
  late ListOfDaysLinkedinModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListOfDaysLinkedinModel());

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

    return StreamBuilder<List<LinkedinPostsRecord>>(
      stream: queryLinkedinPostsRecord(
        queryBuilder: (linkedinPostsRecord) => linkedinPostsRecord
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
        List<LinkedinPostsRecord> containerLinkedinPostsRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final containerLinkedinPostsRecord =
            containerLinkedinPostsRecordList.isNotEmpty
                ? containerLinkedinPostsRecordList.first
                : null;
        return Container(
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(100.0, 0.0, 100.0, 0.0),
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
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Post It',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
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
                    SizedBox(
                      width: 500.0,
                      height: 500.0,
                      child: custom_widgets.LinkedInTemplate(
                        width: 500.0,
                        height: 500.0,
                        mediaUrl: containerLinkedinPostsRecord?.image,
                        headline: containerLinkedinPostsRecord?.title,
                        linkDescription: containerLinkedinPostsRecord?.mainText,
                        mainText: containerLinkedinPostsRecord?.mainText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
