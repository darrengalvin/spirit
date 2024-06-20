import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'chat_window_model.dart';
export 'chat_window_model.dart';

class ChatWindowWidget extends StatefulWidget {
  const ChatWindowWidget({
    super.key,
    required this.companyDoc,
  });

  final CompaniesRecord? companyDoc;

  @override
  State<ChatWindowWidget> createState() => _ChatWindowWidgetState();
}

class _ChatWindowWidgetState extends State<ChatWindowWidget>
    with TickerProviderStateMixin {
  late ChatWindowModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatWindowModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: const Text('about to query'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
      _model.checkingForChats = await queryChatsDocumentsRecordOnce(
        queryBuilder: (chatsDocumentsRecord) => chatsDocumentsRecord
            .where(
              'user_id',
              isEqualTo: currentUserReference?.id,
            )
            .where(
              'thread_id',
              isEqualTo: valueOrDefault(currentUserDocument?.diaryThread, ''),
            ),
      );
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: const Text('There are '),
            content: Text(valueOrDefault<String>(
              _model.checkingForChats?.length.toString(),
              '00000000',
            )),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
      await _model.columnOldChats?.animateTo(
        _model.columnOldChats!.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      if (_model.checkingForChats!.isEmpty) {
        var chatsDocumentsRecordReference =
            ChatsDocumentsRecord.collection.doc();
        await chatsDocumentsRecordReference.set(createChatsDocumentsRecordData(
          role: 'ai',
          text: 'Welcome, ',
          companyDocId: FFAppState().selectedCompanyId,
          threadId:
              valueOrDefault(currentUserDocument?.diaryThread, '') != ''
                  ? valueOrDefault<String>(
                      valueOrDefault(currentUserDocument?.diaryThread, ''),
                      'none',
                    )
                  : valueOrDefault<String>(
                      '${currentUserReference?.id}+${random_data.randomString(
                        6,
                        6,
                        true,
                        true,
                        true,
                      )}',
                      'none',
                    ),
          createdTime: getCurrentTimestamp,
          blockType: '',
          userId: currentUserReference?.id,
        ));
        _model.createdFirstChat = ChatsDocumentsRecord.getDocumentFromData(
            createChatsDocumentsRecordData(
              role: 'ai',
              text: 'Welcome, ',
              companyDocId: FFAppState().selectedCompanyId,
              threadId: valueOrDefault(currentUserDocument?.diaryThread, '') != ''
                  ? valueOrDefault<String>(
                      valueOrDefault(currentUserDocument?.diaryThread, ''),
                      'none',
                    )
                  : valueOrDefault<String>(
                      '${currentUserReference?.id}+${random_data.randomString(
                        6,
                        6,
                        true,
                        true,
                        true,
                      )}',
                      'none',
                    ),
              createdTime: getCurrentTimestamp,
              blockType: '',
              userId: currentUserReference?.id,
            ),
            chatsDocumentsRecordReference);
        await _model.columnOldChats?.animateTo(
          _model.columnOldChats!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
        );
        if (!(valueOrDefault(currentUserDocument?.diaryThread, '') != '')) {
          await currentUserReference!.update(createUsersRecordData(
            diaryThread: _model.createdFirstChat?.threadId,
          ));
        }

        _model.updatePage(() {});
      }
    });

    _model.chatEntrytTEXTTextController ??= TextEditingController();
    _model.chatEntrytTEXTFocusNode ??= FocusNode();

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          SaturateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1450.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.elasticOut,
            delay: 260.0.ms,
            duration: 1820.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          SaturateEffect(
            curve: Curves.easeInOut,
            delay: 6260.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.elasticOut,
            delay: 260.0.ms,
            duration: 1820.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          SaturateEffect(
            curve: Curves.easeInOut,
            delay: 6260.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 240.0.ms,
            duration: 1960.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          SaturateEffect(
            curve: Curves.easeInOut,
            delay: 2200.0.ms,
            duration: 1230.0.ms,
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
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, 1.0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.9,
                    ),
                    decoration: const BoxDecoration(),
                    alignment: const AlignmentDirectional(-1.0, 1.0),
                    child: SingleChildScrollView(
                      primary: false,
                      controller: _model.columnPoss,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 15.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) =>
                                      StreamBuilder<List<ChatsDocumentsRecord>>(
                                    stream: queryChatsDocumentsRecord(
                                      queryBuilder: (chatsDocumentsRecord) =>
                                          chatsDocumentsRecord
                                              .where(
                                                'thread_id',
                                                isEqualTo: valueOrDefault(
                                                    currentUserDocument
                                                        ?.diaryThread,
                                                    ''),
                                              )
                                              .where(
                                                'companyDocId',
                                                isEqualTo: FFAppState()
                                                    .selectedCompanyId,
                                              )
                                              .where(
                                                'user_id',
                                                isEqualTo:
                                                    currentUserReference?.id,
                                              )
                                              .orderBy('created_time'),
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
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<ChatsDocumentsRecord>
                                          maxWidthChatsDocumentsRecordList =
                                          snapshot.data!;
                                      return Container(
                                        width: double.infinity,
                                        constraints: const BoxConstraints(
                                          maxWidth: 600.0,
                                          maxHeight: 600.0,
                                        ),
                                        decoration: const BoxDecoration(),
                                        child: Align(
                                          alignment:
                                              const AlignmentDirectional(0.0, 1.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final chatsDocuments =
                                                    maxWidthChatsDocumentsRecordList
                                                        .toList();
                                                return SingleChildScrollView(
                                                  primary: false,
                                                  controller:
                                                      _model.columnOldChats,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                        chatsDocuments.length,
                                                        (chatsDocumentsIndex) {
                                                      final chatsDocumentsItem =
                                                          chatsDocuments[
                                                              chatsDocumentsIndex];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    20.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            5.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    if (chatsDocumentsItem
                                                                            .role ==
                                                                        'human')
                                                                      Container(
                                                                        constraints:
                                                                            const BoxConstraints(
                                                                          minWidth:
                                                                              300.0,
                                                                          maxWidth:
                                                                              450.0,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          borderRadius:
                                                                              BorderRadius.circular(22.0),
                                                                        ),
                                                                        child:
                                                                            Opacity(
                                                                          opacity:
                                                                              12.0,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                chatsDocumentsItem.text,
                                                                                'test is here',
                                                                              ),
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Inter',
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            if (chatsDocumentsItem
                                                                    .role ==
                                                                'ai')
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        15.0,
                                                                        0.0,
                                                                        15.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if (chatsDocumentsItem
                                                                            .role ==
                                                                        'ai')
                                                                      Container(
                                                                        constraints:
                                                                            const BoxConstraints(
                                                                          minWidth:
                                                                              300.0,
                                                                          maxWidth:
                                                                              450.0,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(22.0),
                                                                        ),
                                                                        child:
                                                                            Opacity(
                                                                          opacity:
                                                                              12.0,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                chatsDocumentsItem.text,
                                                                                'test is here',
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Inter',
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation2']!),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'columnOnPageLoadAnimation']!);
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
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
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (FFAppState().flowiseMessages.isNotEmpty)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    25.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    FFAppState().flowiseMessages.first.message,
                                    'streaming message',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                      ),
                                ).animateOnPageLoad(
                                    animationsMap['textOnPageLoadAnimation3']!),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                  child: Container(
                    height: 100.0,
                    constraints: const BoxConstraints(
                      maxWidth: 700.0,
                    ),
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 500.0,
                                  ),
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 8.0, 0.0),
                                        child: TextFormField(
                                          controller: _model
                                              .chatEntrytTEXTTextController,
                                          focusNode:
                                              _model.chatEntrytTEXTFocusNode,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Talk with ChatName',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 22.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      letterSpacing: 0.0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                              ),
                                          validator: _model
                                              .chatEntrytTEXTTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).tertiary,
                                  icon: Icon(
                                    Icons.arrow_upward,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    // flowise chat document

                                    var chatsDocumentsRecordReference1 =
                                        ChatsDocumentsRecord.collection.doc();
                                    await chatsDocumentsRecordReference1
                                        .set(createChatsDocumentsRecordData(
                                      userId: valueOrDefault<String>(
                                        currentUserReference?.id,
                                        '0',
                                      ),
                                      role: 'human',
                                      text: _model
                                          .chatEntrytTEXTTextController.text,
                                      createdTime: getCurrentTimestamp,
                                      threadId: valueOrDefault(
                                                      currentUserDocument
                                                          ?.diaryThread,
                                                      '') !=
                                                  ''
                                          ? valueOrDefault(
                                              currentUserDocument?.diaryThread,
                                              '')
                                          : '${currentUserReference?.id}+${random_data.randomString(
                                              8,
                                              8,
                                              true,
                                              true,
                                              true,
                                            )}',
                                      companyName:
                                          widget.companyDoc?.companyName,
                                      chatType: 'welcome',
                                      companyDocId:
                                          widget.companyDoc?.reference.id,
                                    ));
                                    _model.createdThread2 = ChatsDocumentsRecord
                                        .getDocumentFromData(
                                            createChatsDocumentsRecordData(
                                              userId: valueOrDefault<String>(
                                                currentUserReference?.id,
                                                '0',
                                              ),
                                              role: 'human',
                                              text: _model
                                                  .chatEntrytTEXTTextController
                                                  .text,
                                              createdTime: getCurrentTimestamp,
                                              threadId: valueOrDefault(
                                                              currentUserDocument
                                                                  ?.diaryThread,
                                                              '') !=
                                                          ''
                                                  ? valueOrDefault(
                                                      currentUserDocument
                                                          ?.diaryThread,
                                                      '')
                                                  : '${currentUserReference?.id}+${random_data.randomString(
                                                      8,
                                                      8,
                                                      true,
                                                      true,
                                                      true,
                                                    )}',
                                              companyName: widget
                                                  .companyDoc?.companyName,
                                              chatType: 'welcome',
                                              companyDocId: widget
                                                  .companyDoc?.reference.id,
                                            ),
                                            chatsDocumentsRecordReference1);
                                    if (valueOrDefault(
                                                currentUserDocument
                                                    ?.diaryThread,
                                                '') ==
                                            '') {
                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        diaryThread:
                                            _model.createdThread2?.threadId,
                                      ));
                                    }
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    await _model.columnOldChats?.animateTo(
                                      _model.columnOldChats!.position
                                          .maxScrollExtent,
                                      duration: const Duration(milliseconds: 100),
                                      curve: Curves.ease,
                                    );
                                    await actions.callFlowiseStreamingChat(
                                      _model.chatEntrytTEXTTextController.text,
                                      valueOrDefault<String>(
                                        widget.companyDoc?.conversationPrompt,
                                        '-',
                                      ),
                                      valueOrDefault<String>(
                                        widget.companyDoc?.conversationPrompt,
                                        '-',
                                      ),
                                      '0',
                                      currentUserReference?.id,
                                      currentUserReference?.id,
                                      valueOrDefault<String>(
                                        widget.companyDoc?.supabaseProjectUrl,
                                        'ok',
                                      ),
                                      valueOrDefault<String>(
                                        widget.companyDoc?.tableName,
                                        'ok',
                                      ),
                                      valueOrDefault<String>(
                                        widget.companyDoc?.supabaseApi,
                                        'ok',
                                      ),
                                      valueOrDefault<String>(
                                        widget.companyDoc?.queryName,
                                        'ok',
                                      ),
                                      false,
                                      1000,
                                      () async {
                                        await _model.columnOldChats?.animateTo(
                                          _model.columnOldChats!.position
                                              .maxScrollExtent,
                                          duration: const Duration(milliseconds: 100),
                                          curve: Curves.ease,
                                        );
                                      },
                                      () async {
                                        await _model.columnOldChats?.animateTo(
                                          _model.columnOldChats!.position
                                              .maxScrollExtent,
                                          duration: const Duration(milliseconds: 100),
                                          curve: Curves.ease,
                                        );
                                      },
                                      '000',
                                    );
                                    while (FFAppState().isStreamingComplete ==
                                        false) {
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      await _model.columnOldChats?.animateTo(
                                        _model.columnOldChats!.position
                                            .maxScrollExtent,
                                        duration: const Duration(milliseconds: 100),
                                        curve: Curves.ease,
                                      );
                                      await _model.columnPoss?.animateTo(
                                        _model.columnPoss!.position
                                            .maxScrollExtent,
                                        duration: const Duration(milliseconds: 100),
                                        curve: Curves.ease,
                                      );
                                    }
                                    // flowise chat document ai

                                    await ChatsDocumentsRecord.collection
                                        .doc()
                                        .set(createChatsDocumentsRecordData(
                                          userId: currentUserReference?.id,
                                          role: 'ai',
                                          text: FFAppState()
                                              .flowiseMessages
                                              .first
                                              .message,
                                          createdTime: getCurrentTimestamp,
                                          threadId: valueOrDefault(
                                              currentUserDocument?.diaryThread,
                                              ''),
                                          companyName:
                                              widget.companyDoc?.companyName,
                                          chatType: 'welcome',
                                          companyDocId:
                                              widget.companyDoc?.reference.id,
                                        ));
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    await _model.columnOldChats?.animateTo(
                                      _model.columnOldChats!.position
                                          .maxScrollExtent,
                                      duration: const Duration(milliseconds: 100),
                                      curve: Curves.ease,
                                    );
                                    FFAppState().flowiseMessages = [];
                                    setState(() {});
                                    setState(() {
                                      _model.chatEntrytTEXTTextController
                                          ?.clear();
                                    });
                                    await _model.columnOldChats?.animateTo(
                                      _model.columnOldChats!.position
                                          .maxScrollExtent,
                                      duration: const Duration(milliseconds: 100),
                                      curve: Curves.ease,
                                    );

                                    setState(() {});
                                  },
                                ),
                              ],
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
    );
  }
}
