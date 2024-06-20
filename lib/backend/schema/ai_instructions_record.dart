import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AiInstructionsRecord extends FirestoreRecord {
  AiInstructionsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "topic" field.
  String? _topic;
  String get topic => _topic ?? '';
  bool hasTopic() => _topic != null;

  // "instructions" field.
  String? _instructions;
  String get instructions => _instructions ?? '';
  bool hasInstructions() => _instructions != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "associatedCompanyId" field.
  String? _associatedCompanyId;
  String get associatedCompanyId => _associatedCompanyId ?? '';
  bool hasAssociatedCompanyId() => _associatedCompanyId != null;

  void _initializeFields() {
    _topic = snapshotData['topic'] as String?;
    _instructions = snapshotData['instructions'] as String?;
    _description = snapshotData['description'] as String?;
    _type = snapshotData['type'] as String?;
    _associatedCompanyId = snapshotData['associatedCompanyId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('aiInstructions');

  static Stream<AiInstructionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AiInstructionsRecord.fromSnapshot(s));

  static Future<AiInstructionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AiInstructionsRecord.fromSnapshot(s));

  static AiInstructionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AiInstructionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AiInstructionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AiInstructionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AiInstructionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AiInstructionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAiInstructionsRecordData({
  String? topic,
  String? instructions,
  String? description,
  String? type,
  String? associatedCompanyId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'topic': topic,
      'instructions': instructions,
      'description': description,
      'type': type,
      'associatedCompanyId': associatedCompanyId,
    }.withoutNulls,
  );

  return firestoreData;
}

class AiInstructionsRecordDocumentEquality
    implements Equality<AiInstructionsRecord> {
  const AiInstructionsRecordDocumentEquality();

  @override
  bool equals(AiInstructionsRecord? e1, AiInstructionsRecord? e2) {
    return e1?.topic == e2?.topic &&
        e1?.instructions == e2?.instructions &&
        e1?.description == e2?.description &&
        e1?.type == e2?.type &&
        e1?.associatedCompanyId == e2?.associatedCompanyId;
  }

  @override
  int hash(AiInstructionsRecord? e) => const ListEquality().hash([
        e?.topic,
        e?.instructions,
        e?.description,
        e?.type,
        e?.associatedCompanyId
      ]);

  @override
  bool isValidKey(Object? o) => o is AiInstructionsRecord;
}
