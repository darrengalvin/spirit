import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ActivitiesRecord extends FirestoreRecord {
  ActivitiesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "activityName" field.
  String? _activityName;
  String get activityName => _activityName ?? '';
  bool hasActivityName() => _activityName != null;

  // "dateOfActivity" field.
  DateTime? _dateOfActivity;
  DateTime? get dateOfActivity => _dateOfActivity;
  bool hasDateOfActivity() => _dateOfActivity != null;

  // "activityImage" field.
  String? _activityImage;
  String get activityImage => _activityImage ?? '';
  bool hasActivityImage() => _activityImage != null;

  // "activitySummary" field.
  String? _activitySummary;
  String get activitySummary => _activitySummary ?? '';
  bool hasActivitySummary() => _activitySummary != null;

  // "linkedAwarenessDayId" field.
  String? _linkedAwarenessDayId;
  String get linkedAwarenessDayId => _linkedAwarenessDayId ?? '';
  bool hasLinkedAwarenessDayId() => _linkedAwarenessDayId != null;

  // "ageGroup" field.
  String? _ageGroup;
  String get ageGroup => _ageGroup ?? '';
  bool hasAgeGroup() => _ageGroup != null;

  // "activityDate" field.
  DateTime? _activityDate;
  DateTime? get activityDate => _activityDate;
  bool hasActivityDate() => _activityDate != null;

  // "activityDescription" field.
  List<String>? _activityDescription;
  List<String> get activityDescription => _activityDescription ?? const [];
  bool hasActivityDescription() => _activityDescription != null;

  // "itemsRequired" field.
  List<String>? _itemsRequired;
  List<String> get itemsRequired => _itemsRequired ?? const [];
  bool hasItemsRequired() => _itemsRequired != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "associatedCompanyId" field.
  String? _associatedCompanyId;
  String get associatedCompanyId => _associatedCompanyId ?? '';
  bool hasAssociatedCompanyId() => _associatedCompanyId != null;

  void _initializeFields() {
    _activityName = snapshotData['activityName'] as String?;
    _dateOfActivity = snapshotData['dateOfActivity'] as DateTime?;
    _activityImage = snapshotData['activityImage'] as String?;
    _activitySummary = snapshotData['activitySummary'] as String?;
    _linkedAwarenessDayId = snapshotData['linkedAwarenessDayId'] as String?;
    _ageGroup = snapshotData['ageGroup'] as String?;
    _activityDate = snapshotData['activityDate'] as DateTime?;
    _activityDescription = getDataList(snapshotData['activityDescription']);
    _itemsRequired = getDataList(snapshotData['itemsRequired']);
    _isActive = snapshotData['isActive'] as bool?;
    _associatedCompanyId = snapshotData['associatedCompanyId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('activities');

  static Stream<ActivitiesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ActivitiesRecord.fromSnapshot(s));

  static Future<ActivitiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ActivitiesRecord.fromSnapshot(s));

  static ActivitiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ActivitiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ActivitiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ActivitiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ActivitiesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ActivitiesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createActivitiesRecordData({
  String? activityName,
  DateTime? dateOfActivity,
  String? activityImage,
  String? activitySummary,
  String? linkedAwarenessDayId,
  String? ageGroup,
  DateTime? activityDate,
  bool? isActive,
  String? associatedCompanyId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'activityName': activityName,
      'dateOfActivity': dateOfActivity,
      'activityImage': activityImage,
      'activitySummary': activitySummary,
      'linkedAwarenessDayId': linkedAwarenessDayId,
      'ageGroup': ageGroup,
      'activityDate': activityDate,
      'isActive': isActive,
      'associatedCompanyId': associatedCompanyId,
    }.withoutNulls,
  );

  return firestoreData;
}

class ActivitiesRecordDocumentEquality implements Equality<ActivitiesRecord> {
  const ActivitiesRecordDocumentEquality();

  @override
  bool equals(ActivitiesRecord? e1, ActivitiesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.activityName == e2?.activityName &&
        e1?.dateOfActivity == e2?.dateOfActivity &&
        e1?.activityImage == e2?.activityImage &&
        e1?.activitySummary == e2?.activitySummary &&
        e1?.linkedAwarenessDayId == e2?.linkedAwarenessDayId &&
        e1?.ageGroup == e2?.ageGroup &&
        e1?.activityDate == e2?.activityDate &&
        listEquality.equals(e1?.activityDescription, e2?.activityDescription) &&
        listEquality.equals(e1?.itemsRequired, e2?.itemsRequired) &&
        e1?.isActive == e2?.isActive &&
        e1?.associatedCompanyId == e2?.associatedCompanyId;
  }

  @override
  int hash(ActivitiesRecord? e) => const ListEquality().hash([
        e?.activityName,
        e?.dateOfActivity,
        e?.activityImage,
        e?.activitySummary,
        e?.linkedAwarenessDayId,
        e?.ageGroup,
        e?.activityDate,
        e?.activityDescription,
        e?.itemsRequired,
        e?.isActive,
        e?.associatedCompanyId
      ]);

  @override
  bool isValidKey(Object? o) => o is ActivitiesRecord;
}
