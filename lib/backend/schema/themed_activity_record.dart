import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ThemedActivityRecord extends FirestoreRecord {
  ThemedActivityRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "activityName" field.
  String? _activityName;
  String get activityName => _activityName ?? '';
  bool hasActivityName() => _activityName != null;

  // "activityDescription" field.
  String? _activityDescription;
  String get activityDescription => _activityDescription ?? '';
  bool hasActivityDescription() => _activityDescription != null;

  // "activitySummary" field.
  String? _activitySummary;
  String get activitySummary => _activitySummary ?? '';
  bool hasActivitySummary() => _activitySummary != null;

  // "linkedAwarenessDayId" field.
  String? _linkedAwarenessDayId;
  String get linkedAwarenessDayId => _linkedAwarenessDayId ?? '';
  bool hasLinkedAwarenessDayId() => _linkedAwarenessDayId != null;

  // "itemsRequired" field.
  List<String>? _itemsRequired;
  List<String> get itemsRequired => _itemsRequired ?? const [];
  bool hasItemsRequired() => _itemsRequired != null;

  // "ageGroup" field.
  String? _ageGroup;
  String get ageGroup => _ageGroup ?? '';
  bool hasAgeGroup() => _ageGroup != null;

  // "activityDate" field.
  DateTime? _activityDate;
  DateTime? get activityDate => _activityDate;
  bool hasActivityDate() => _activityDate != null;

  // "activityImage" field.
  String? _activityImage;
  String get activityImage => _activityImage ?? '';
  bool hasActivityImage() => _activityImage != null;

  // "associatedCompanyId" field.
  String? _associatedCompanyId;
  String get associatedCompanyId => _associatedCompanyId ?? '';
  bool hasAssociatedCompanyId() => _associatedCompanyId != null;

  void _initializeFields() {
    _activityName = snapshotData['activityName'] as String?;
    _activityDescription = snapshotData['activityDescription'] as String?;
    _activitySummary = snapshotData['activitySummary'] as String?;
    _linkedAwarenessDayId = snapshotData['linkedAwarenessDayId'] as String?;
    _itemsRequired = getDataList(snapshotData['itemsRequired']);
    _ageGroup = snapshotData['ageGroup'] as String?;
    _activityDate = snapshotData['activityDate'] as DateTime?;
    _activityImage = snapshotData['activityImage'] as String?;
    _associatedCompanyId = snapshotData['associatedCompanyId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('themedActivity');

  static Stream<ThemedActivityRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ThemedActivityRecord.fromSnapshot(s));

  static Future<ThemedActivityRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ThemedActivityRecord.fromSnapshot(s));

  static ThemedActivityRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ThemedActivityRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ThemedActivityRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ThemedActivityRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ThemedActivityRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ThemedActivityRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createThemedActivityRecordData({
  String? activityName,
  String? activityDescription,
  String? activitySummary,
  String? linkedAwarenessDayId,
  String? ageGroup,
  DateTime? activityDate,
  String? activityImage,
  String? associatedCompanyId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'activityName': activityName,
      'activityDescription': activityDescription,
      'activitySummary': activitySummary,
      'linkedAwarenessDayId': linkedAwarenessDayId,
      'ageGroup': ageGroup,
      'activityDate': activityDate,
      'activityImage': activityImage,
      'associatedCompanyId': associatedCompanyId,
    }.withoutNulls,
  );

  return firestoreData;
}

class ThemedActivityRecordDocumentEquality
    implements Equality<ThemedActivityRecord> {
  const ThemedActivityRecordDocumentEquality();

  @override
  bool equals(ThemedActivityRecord? e1, ThemedActivityRecord? e2) {
    const listEquality = ListEquality();
    return e1?.activityName == e2?.activityName &&
        e1?.activityDescription == e2?.activityDescription &&
        e1?.activitySummary == e2?.activitySummary &&
        e1?.linkedAwarenessDayId == e2?.linkedAwarenessDayId &&
        listEquality.equals(e1?.itemsRequired, e2?.itemsRequired) &&
        e1?.ageGroup == e2?.ageGroup &&
        e1?.activityDate == e2?.activityDate &&
        e1?.activityImage == e2?.activityImage &&
        e1?.associatedCompanyId == e2?.associatedCompanyId;
  }

  @override
  int hash(ThemedActivityRecord? e) => const ListEquality().hash([
        e?.activityName,
        e?.activityDescription,
        e?.activitySummary,
        e?.linkedAwarenessDayId,
        e?.itemsRequired,
        e?.ageGroup,
        e?.activityDate,
        e?.activityImage,
        e?.associatedCompanyId
      ]);

  @override
  bool isValidKey(Object? o) => o is ThemedActivityRecord;
}
