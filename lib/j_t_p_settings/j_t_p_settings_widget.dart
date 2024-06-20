import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/login_box_widget.dart';
import '/components/settings_widget.dart';
import '/components/sidemenu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'j_t_p_settings_model.dart';
export 'j_t_p_settings_model.dart';

class JTPSettingsWidget extends StatefulWidget {
  const JTPSettingsWidget({super.key});

  @override
  State<JTPSettingsWidget> createState() => _JTPSettingsWidgetState();
}

class _JTPSettingsWidgetState extends State<JTPSettingsWidget> {
  late JTPSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JTPSettingsModel());

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
                  color: FlutterFlowTheme.of(context).tertiary,
                ),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: wrapWithModel(
                              model: _model.settingsModel,
                              updateCallback: () => setState(() {}),
                              updateOnChange: true,
                              child: SettingsWidget(
                                companyDocId: containerCompaniesRecordList
                                    .first.reference.id,
                                companyDoc: containerCompaniesRecordList.first,
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
