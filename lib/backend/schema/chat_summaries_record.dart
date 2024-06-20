import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatSummariesRecord extends FirestoreRecord {
  ChatSummariesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "string" field.
  String? _string;
  String get string => _string ?? '';
  bool hasString() => _string != null;

  // "listOfChats" field.
  List<String>? _listOfChats;
  List<String> get listOfChats => _listOfChats ?? const [];
  bool hasListOfChats() => _listOfChats != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _string = snapshotData['string'] as String?;
    _listOfChats = getDataList(snapshotData['listOfChats']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chatSummaries');

  static Stream<ChatSummariesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatSummariesRecord.fromSnapshot(s));

  static Future<ChatSummariesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatSummariesRecord.fromSnapshot(s));

  static ChatSummariesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatSummariesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatSummariesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatSummariesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatSummariesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatSummariesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatSummariesRecordData({
  DateTime? date,
  String? string,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'string': string,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatSummariesRecordDocumentEquality
    implements Equality<ChatSummariesRecord> {
  const ChatSummariesRecordDocumentEquality();

  @override
  bool equals(ChatSummariesRecord? e1, ChatSummariesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.date == e2?.date &&
        e1?.string == e2?.string &&
        listEquality.equals(e1?.listOfChats, e2?.listOfChats);
  }

  @override
  int hash(ChatSummariesRecord? e) =>
      const ListEquality().hash([e?.date, e?.string, e?.listOfChats]);

  @override
  bool isValidKey(Object? o) => o is ChatSummariesRecord;
}
