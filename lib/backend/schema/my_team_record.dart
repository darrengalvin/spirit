import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyTeamRecord extends FirestoreRecord {
  MyTeamRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "backgroundImage" field.
  String? _backgroundImage;
  String get backgroundImage => _backgroundImage ?? '';
  bool hasBackgroundImage() => _backgroundImage != null;

  // "welcomeMessage" field.
  String? _welcomeMessage;
  String get welcomeMessage => _welcomeMessage ?? '';
  bool hasWelcomeMessage() => _welcomeMessage != null;

  // "skills" field.
  List<String>? _skills;
  List<String> get skills => _skills ?? const [];
  bool hasSkills() => _skills != null;

  // "memberId" field.
  String? _memberId;
  String get memberId => _memberId ?? '';
  bool hasMemberId() => _memberId != null;

  // "company" field.
  String? _company;
  String get company => _company ?? '';
  bool hasCompany() => _company != null;

  // "memberName" field.
  String? _memberName;
  String get memberName => _memberName ?? '';
  bool hasMemberName() => _memberName != null;

  // "memberSummary" field.
  String? _memberSummary;
  String get memberSummary => _memberSummary ?? '';
  bool hasMemberSummary() => _memberSummary != null;

  // "positionId" field.
  int? _positionId;
  int get positionId => _positionId ?? 0;
  bool hasPositionId() => _positionId != null;

  // "persona" field.
  String? _persona;
  String get persona => _persona ?? '';
  bool hasPersona() => _persona != null;

  // "buzzWordsPhrases" field.
  List<String>? _buzzWordsPhrases;
  List<String> get buzzWordsPhrases => _buzzWordsPhrases ?? const [];
  bool hasBuzzWordsPhrases() => _buzzWordsPhrases != null;

  void _initializeFields() {
    _role = snapshotData['role'] as String?;
    _image = snapshotData['image'] as String?;
    _backgroundImage = snapshotData['backgroundImage'] as String?;
    _welcomeMessage = snapshotData['welcomeMessage'] as String?;
    _skills = getDataList(snapshotData['skills']);
    _memberId = snapshotData['memberId'] as String?;
    _company = snapshotData['company'] as String?;
    _memberName = snapshotData['memberName'] as String?;
    _memberSummary = snapshotData['memberSummary'] as String?;
    _positionId = castToType<int>(snapshotData['positionId']);
    _persona = snapshotData['persona'] as String?;
    _buzzWordsPhrases = getDataList(snapshotData['buzzWordsPhrases']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('myTeam');

  static Stream<MyTeamRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MyTeamRecord.fromSnapshot(s));

  static Future<MyTeamRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MyTeamRecord.fromSnapshot(s));

  static MyTeamRecord fromSnapshot(DocumentSnapshot snapshot) => MyTeamRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MyTeamRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MyTeamRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MyTeamRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MyTeamRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMyTeamRecordData({
  String? role,
  String? image,
  String? backgroundImage,
  String? welcomeMessage,
  String? memberId,
  String? company,
  String? memberName,
  String? memberSummary,
  int? positionId,
  String? persona,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'role': role,
      'image': image,
      'backgroundImage': backgroundImage,
      'welcomeMessage': welcomeMessage,
      'memberId': memberId,
      'company': company,
      'memberName': memberName,
      'memberSummary': memberSummary,
      'positionId': positionId,
      'persona': persona,
    }.withoutNulls,
  );

  return firestoreData;
}

class MyTeamRecordDocumentEquality implements Equality<MyTeamRecord> {
  const MyTeamRecordDocumentEquality();

  @override
  bool equals(MyTeamRecord? e1, MyTeamRecord? e2) {
    const listEquality = ListEquality();
    return e1?.role == e2?.role &&
        e1?.image == e2?.image &&
        e1?.backgroundImage == e2?.backgroundImage &&
        e1?.welcomeMessage == e2?.welcomeMessage &&
        listEquality.equals(e1?.skills, e2?.skills) &&
        e1?.memberId == e2?.memberId &&
        e1?.company == e2?.company &&
        e1?.memberName == e2?.memberName &&
        e1?.memberSummary == e2?.memberSummary &&
        e1?.positionId == e2?.positionId &&
        e1?.persona == e2?.persona &&
        listEquality.equals(e1?.buzzWordsPhrases, e2?.buzzWordsPhrases);
  }

  @override
  int hash(MyTeamRecord? e) => const ListEquality().hash([
        e?.role,
        e?.image,
        e?.backgroundImage,
        e?.welcomeMessage,
        e?.skills,
        e?.memberId,
        e?.company,
        e?.memberName,
        e?.memberSummary,
        e?.positionId,
        e?.persona,
        e?.buzzWordsPhrases
      ]);

  @override
  bool isValidKey(Object? o) => o is MyTeamRecord;
}
