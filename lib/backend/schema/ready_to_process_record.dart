import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReadyToProcessRecord extends FirestoreRecord {
  ReadyToProcessRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "awarenessDayDetails" field.
  AwarenessStruct? _awarenessDayDetails;
  AwarenessStruct get awarenessDayDetails =>
      _awarenessDayDetails ?? AwarenessStruct();
  bool hasAwarenessDayDetails() => _awarenessDayDetails != null;

  // "jobNumber" field.
  String? _jobNumber;
  String get jobNumber => _jobNumber ?? '';
  bool hasJobNumber() => _jobNumber != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "dateCreated" field.
  DateTime? _dateCreated;
  DateTime? get dateCreated => _dateCreated;
  bool hasDateCreated() => _dateCreated != null;

  // "companyOwner" field.
  String? _companyOwner;
  String get companyOwner => _companyOwner ?? '';
  bool hasCompanyOwner() => _companyOwner != null;

  // "companyName" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "generatedByUser" field.
  String? _generatedByUser;
  String get generatedByUser => _generatedByUser ?? '';
  bool hasGeneratedByUser() => _generatedByUser != null;

  void _initializeFields() {
    _awarenessDayDetails =
        AwarenessStruct.maybeFromMap(snapshotData['awarenessDayDetails']);
    _jobNumber = snapshotData['jobNumber'] as String?;
    _status = snapshotData['status'] as String?;
    _type = snapshotData['type'] as String?;
    _dateCreated = snapshotData['dateCreated'] as DateTime?;
    _companyOwner = snapshotData['companyOwner'] as String?;
    _companyName = snapshotData['companyName'] as String?;
    _generatedByUser = snapshotData['generatedByUser'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('readyToProcess');

  static Stream<ReadyToProcessRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReadyToProcessRecord.fromSnapshot(s));

  static Future<ReadyToProcessRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReadyToProcessRecord.fromSnapshot(s));

  static ReadyToProcessRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReadyToProcessRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReadyToProcessRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReadyToProcessRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReadyToProcessRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReadyToProcessRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReadyToProcessRecordData({
  AwarenessStruct? awarenessDayDetails,
  String? jobNumber,
  String? status,
  String? type,
  DateTime? dateCreated,
  String? companyOwner,
  String? companyName,
  String? generatedByUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'awarenessDayDetails': AwarenessStruct().toMap(),
      'jobNumber': jobNumber,
      'status': status,
      'type': type,
      'dateCreated': dateCreated,
      'companyOwner': companyOwner,
      'companyName': companyName,
      'generatedByUser': generatedByUser,
    }.withoutNulls,
  );

  // Handle nested data for "awarenessDayDetails" field.
  addAwarenessStructData(
      firestoreData, awarenessDayDetails, 'awarenessDayDetails');

  return firestoreData;
}

class ReadyToProcessRecordDocumentEquality
    implements Equality<ReadyToProcessRecord> {
  const ReadyToProcessRecordDocumentEquality();

  @override
  bool equals(ReadyToProcessRecord? e1, ReadyToProcessRecord? e2) {
    return e1?.awarenessDayDetails == e2?.awarenessDayDetails &&
        e1?.jobNumber == e2?.jobNumber &&
        e1?.status == e2?.status &&
        e1?.type == e2?.type &&
        e1?.dateCreated == e2?.dateCreated &&
        e1?.companyOwner == e2?.companyOwner &&
        e1?.companyName == e2?.companyName &&
        e1?.generatedByUser == e2?.generatedByUser;
  }

  @override
  int hash(ReadyToProcessRecord? e) => const ListEquality().hash([
        e?.awarenessDayDetails,
        e?.jobNumber,
        e?.status,
        e?.type,
        e?.dateCreated,
        e?.companyOwner,
        e?.companyName,
        e?.generatedByUser
      ]);

  @override
  bool isValidKey(Object? o) => o is ReadyToProcessRecord;
}
