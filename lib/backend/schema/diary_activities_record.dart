import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DiaryActivitiesRecord extends FirestoreRecord {
  DiaryActivitiesRecord._(
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

  // "companyId" field.
  String? _companyId;
  String get companyId => _companyId ?? '';
  bool hasCompanyId() => _companyId != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

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
    _companyId = snapshotData['companyId'] as String?;
    _userId = snapshotData['userId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('diaryActivities');

  static Stream<DiaryActivitiesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DiaryActivitiesRecord.fromSnapshot(s));

  static Future<DiaryActivitiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DiaryActivitiesRecord.fromSnapshot(s));

  static DiaryActivitiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DiaryActivitiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DiaryActivitiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DiaryActivitiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DiaryActivitiesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DiaryActivitiesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDiaryActivitiesRecordData({
  String? activityName,
  DateTime? dateOfActivity,
  String? activityImage,
  String? activitySummary,
  String? linkedAwarenessDayId,
  String? ageGroup,
  DateTime? activityDate,
  bool? isActive,
  String? associatedCompanyId,
  String? companyId,
  String? userId,
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
      'companyId': companyId,
      'userId': userId,
    }.withoutNulls,
  );

  return firestoreData;
}

class DiaryActivitiesRecordDocumentEquality
    implements Equality<DiaryActivitiesRecord> {
  const DiaryActivitiesRecordDocumentEquality();

  @override
  bool equals(DiaryActivitiesRecord? e1, DiaryActivitiesRecord? e2) {
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
        e1?.associatedCompanyId == e2?.associatedCompanyId &&
        e1?.companyId == e2?.companyId &&
        e1?.userId == e2?.userId;
  }

  @override
  int hash(DiaryActivitiesRecord? e) => const ListEquality().hash([
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
        e?.associatedCompanyId,
        e?.companyId,
        e?.userId
      ]);

  @override
  bool isValidKey(Object? o) => o is DiaryActivitiesRecord;
}
