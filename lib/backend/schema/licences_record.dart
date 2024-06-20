import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LicencesRecord extends FirestoreRecord {
  LicencesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "licenceId" field.
  String? _licenceId;
  String get licenceId => _licenceId ?? '';
  bool hasLicenceId() => _licenceId != null;

  // "licenceName" field.
  String? _licenceName;
  String get licenceName => _licenceName ?? '';
  bool hasLicenceName() => _licenceName != null;

  // "licenceMembers" field.
  List<String>? _licenceMembers;
  List<String> get licenceMembers => _licenceMembers ?? const [];
  bool hasLicenceMembers() => _licenceMembers != null;

  void _initializeFields() {
    _licenceId = snapshotData['licenceId'] as String?;
    _licenceName = snapshotData['licenceName'] as String?;
    _licenceMembers = getDataList(snapshotData['licenceMembers']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('licences');

  static Stream<LicencesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LicencesRecord.fromSnapshot(s));

  static Future<LicencesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LicencesRecord.fromSnapshot(s));

  static LicencesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LicencesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LicencesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LicencesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LicencesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LicencesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLicencesRecordData({
  String? licenceId,
  String? licenceName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'licenceId': licenceId,
      'licenceName': licenceName,
    }.withoutNulls,
  );

  return firestoreData;
}

class LicencesRecordDocumentEquality implements Equality<LicencesRecord> {
  const LicencesRecordDocumentEquality();

  @override
  bool equals(LicencesRecord? e1, LicencesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.licenceId == e2?.licenceId &&
        e1?.licenceName == e2?.licenceName &&
        listEquality.equals(e1?.licenceMembers, e2?.licenceMembers);
  }

  @override
  int hash(LicencesRecord? e) => const ListEquality()
      .hash([e?.licenceId, e?.licenceName, e?.licenceMembers]);

  @override
  bool isValidKey(Object? o) => o is LicencesRecord;
}
