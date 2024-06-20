import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsDocumentsRecord extends FirestoreRecord {
  ChatsDocumentsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "user_ref" field.
  String? _userRef;
  String get userRef => _userRef ?? '';
  bool hasUserRef() => _userRef != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "block_type" field.
  String? _blockType;
  String get blockType => _blockType ?? '';
  bool hasBlockType() => _blockType != null;

  // "block_name" field.
  String? _blockName;
  String get blockName => _blockName ?? '';
  bool hasBlockName() => _blockName != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "session_id" field.
  String? _sessionId;
  String get sessionId => _sessionId ?? '';
  bool hasSessionId() => _sessionId != null;

  // "tile_id" field.
  String? _tileId;
  String get tileId => _tileId ?? '';
  bool hasTileId() => _tileId != null;

  // "block_id" field.
  String? _blockId;
  String get blockId => _blockId ?? '';
  bool hasBlockId() => _blockId != null;

  // "thread_id" field.
  String? _threadId;
  String get threadId => _threadId ?? '';
  bool hasThreadId() => _threadId != null;

  // "buttonTrigger" field.
  String? _buttonTrigger;
  String get buttonTrigger => _buttonTrigger ?? '';
  bool hasButtonTrigger() => _buttonTrigger != null;

  // "learnCardId" field.
  String? _learnCardId;
  String get learnCardId => _learnCardId ?? '';
  bool hasLearnCardId() => _learnCardId != null;

  // "isSystemMessage" field.
  bool? _isSystemMessage;
  bool get isSystemMessage => _isSystemMessage ?? false;
  bool hasIsSystemMessage() => _isSystemMessage != null;

  // "companyName" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "chatType" field.
  String? _chatType;
  String get chatType => _chatType ?? '';
  bool hasChatType() => _chatType != null;

  // "companyDocId" field.
  String? _companyDocId;
  String get companyDocId => _companyDocId ?? '';
  bool hasCompanyDocId() => _companyDocId != null;

  // "showToAll" field.
  bool? _showToAll;
  bool get showToAll => _showToAll ?? false;
  bool hasShowToAll() => _showToAll != null;

  // "showToMemberIds" field.
  List<String>? _showToMemberIds;
  List<String> get showToMemberIds => _showToMemberIds ?? const [];
  bool hasShowToMemberIds() => _showToMemberIds != null;

  // "style" field.
  String? _style;
  String get style => _style ?? '';
  bool hasStyle() => _style != null;

  // "isJournalEntry" field.
  bool? _isJournalEntry;
  bool get isJournalEntry => _isJournalEntry ?? false;
  bool hasIsJournalEntry() => _isJournalEntry != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as String?;
    _role = snapshotData['role'] as String?;
    _text = snapshotData['text'] as String?;
    _blockType = snapshotData['block_type'] as String?;
    _blockName = snapshotData['block_name'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _sessionId = snapshotData['session_id'] as String?;
    _tileId = snapshotData['tile_id'] as String?;
    _blockId = snapshotData['block_id'] as String?;
    _threadId = snapshotData['thread_id'] as String?;
    _buttonTrigger = snapshotData['buttonTrigger'] as String?;
    _learnCardId = snapshotData['learnCardId'] as String?;
    _isSystemMessage = snapshotData['isSystemMessage'] as bool?;
    _companyName = snapshotData['companyName'] as String?;
    _chatType = snapshotData['chatType'] as String?;
    _companyDocId = snapshotData['companyDocId'] as String?;
    _showToAll = snapshotData['showToAll'] as bool?;
    _showToMemberIds = getDataList(snapshotData['showToMemberIds']);
    _style = snapshotData['style'] as String?;
    _isJournalEntry = snapshotData['isJournalEntry'] as bool?;
    _userId = snapshotData['user_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chatsDocuments');

  static Stream<ChatsDocumentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsDocumentsRecord.fromSnapshot(s));

  static Future<ChatsDocumentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsDocumentsRecord.fromSnapshot(s));

  static ChatsDocumentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatsDocumentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsDocumentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsDocumentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsDocumentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsDocumentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsDocumentsRecordData({
  String? userRef,
  String? role,
  String? text,
  String? blockType,
  String? blockName,
  DateTime? createdTime,
  String? sessionId,
  String? tileId,
  String? blockId,
  String? threadId,
  String? buttonTrigger,
  String? learnCardId,
  bool? isSystemMessage,
  String? companyName,
  String? chatType,
  String? companyDocId,
  bool? showToAll,
  String? style,
  bool? isJournalEntry,
  String? userId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'role': role,
      'text': text,
      'block_type': blockType,
      'block_name': blockName,
      'created_time': createdTime,
      'session_id': sessionId,
      'tile_id': tileId,
      'block_id': blockId,
      'thread_id': threadId,
      'buttonTrigger': buttonTrigger,
      'learnCardId': learnCardId,
      'isSystemMessage': isSystemMessage,
      'companyName': companyName,
      'chatType': chatType,
      'companyDocId': companyDocId,
      'showToAll': showToAll,
      'style': style,
      'isJournalEntry': isJournalEntry,
      'user_id': userId,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsDocumentsRecordDocumentEquality
    implements Equality<ChatsDocumentsRecord> {
  const ChatsDocumentsRecordDocumentEquality();

  @override
  bool equals(ChatsDocumentsRecord? e1, ChatsDocumentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userRef == e2?.userRef &&
        e1?.role == e2?.role &&
        e1?.text == e2?.text &&
        e1?.blockType == e2?.blockType &&
        e1?.blockName == e2?.blockName &&
        e1?.createdTime == e2?.createdTime &&
        e1?.sessionId == e2?.sessionId &&
        e1?.tileId == e2?.tileId &&
        e1?.blockId == e2?.blockId &&
        e1?.threadId == e2?.threadId &&
        e1?.buttonTrigger == e2?.buttonTrigger &&
        e1?.learnCardId == e2?.learnCardId &&
        e1?.isSystemMessage == e2?.isSystemMessage &&
        e1?.companyName == e2?.companyName &&
        e1?.chatType == e2?.chatType &&
        e1?.companyDocId == e2?.companyDocId &&
        e1?.showToAll == e2?.showToAll &&
        listEquality.equals(e1?.showToMemberIds, e2?.showToMemberIds) &&
        e1?.style == e2?.style &&
        e1?.isJournalEntry == e2?.isJournalEntry &&
        e1?.userId == e2?.userId;
  }

  @override
  int hash(ChatsDocumentsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.role,
        e?.text,
        e?.blockType,
        e?.blockName,
        e?.createdTime,
        e?.sessionId,
        e?.tileId,
        e?.blockId,
        e?.threadId,
        e?.buttonTrigger,
        e?.learnCardId,
        e?.isSystemMessage,
        e?.companyName,
        e?.chatType,
        e?.companyDocId,
        e?.showToAll,
        e?.showToMemberIds,
        e?.style,
        e?.isJournalEntry,
        e?.userId
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsDocumentsRecord;
}
