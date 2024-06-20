import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeachersRecord extends FirestoreRecord {
  TeachersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "teacherName" field.
  String? _teacherName;
  String get teacherName => _teacherName ?? '';
  bool hasTeacherName() => _teacherName != null;

  // "teachersSchool" field.
  String? _teachersSchool;
  String get teachersSchool => _teachersSchool ?? '';
  bool hasTeachersSchool() => _teachersSchool != null;

  // "teachersEmail" field.
  String? _teachersEmail;
  String get teachersEmail => _teachersEmail ?? '';
  bool hasTeachersEmail() => _teachersEmail != null;

  // "teachersDocId" field.
  String? _teachersDocId;
  String get teachersDocId => _teachersDocId ?? '';
  bool hasTeachersDocId() => _teachersDocId != null;

  // "teachersPhoto" field.
  String? _teachersPhoto;
  String get teachersPhoto => _teachersPhoto ?? '';
  bool hasTeachersPhoto() => _teachersPhoto != null;

  // "companyDocId" field.
  String? _companyDocId;
  String get companyDocId => _companyDocId ?? '';
  bool hasCompanyDocId() => _companyDocId != null;

  void _initializeFields() {
    _teacherName = snapshotData['teacherName'] as String?;
    _teachersSchool = snapshotData['teachersSchool'] as String?;
    _teachersEmail = snapshotData['teachersEmail'] as String?;
    _teachersDocId = snapshotData['teachersDocId'] as String?;
    _teachersPhoto = snapshotData['teachersPhoto'] as String?;
    _companyDocId = snapshotData['companyDocId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('teachers');

  static Stream<TeachersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeachersRecord.fromSnapshot(s));

  static Future<TeachersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeachersRecord.fromSnapshot(s));

  static TeachersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TeachersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeachersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeachersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeachersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeachersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeachersRecordData({
  String? teacherName,
  String? teachersSchool,
  String? teachersEmail,
  String? teachersDocId,
  String? teachersPhoto,
  String? companyDocId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'teacherName': teacherName,
      'teachersSchool': teachersSchool,
      'teachersEmail': teachersEmail,
      'teachersDocId': teachersDocId,
      'teachersPhoto': teachersPhoto,
      'companyDocId': companyDocId,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeachersRecordDocumentEquality implements Equality<TeachersRecord> {
  const TeachersRecordDocumentEquality();

  @override
  bool equals(TeachersRecord? e1, TeachersRecord? e2) {
    return e1?.teacherName == e2?.teacherName &&
        e1?.teachersSchool == e2?.teachersSchool &&
        e1?.teachersEmail == e2?.teachersEmail &&
        e1?.teachersDocId == e2?.teachersDocId &&
        e1?.teachersPhoto == e2?.teachersPhoto &&
        e1?.companyDocId == e2?.companyDocId;
  }

  @override
  int hash(TeachersRecord? e) => const ListEquality().hash([
        e?.teacherName,
        e?.teachersSchool,
        e?.teachersEmail,
        e?.teachersDocId,
        e?.teachersPhoto,
        e?.companyDocId
      ]);

  @override
  bool isValidKey(Object? o) => o is TeachersRecord;
}
