import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AwarenessDaysRecord extends FirestoreRecord {
  AwarenessDaysRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "isFeatured" field.
  bool? _isFeatured;
  bool get isFeatured => _isFeatured ?? false;
  bool hasIsFeatured() => _isFeatured != null;

  // "item" field.
  String? _item;
  String get item => _item ?? '';
  bool hasItem() => _item != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  bool hasSource() => _source != null;

  // "selected" field.
  bool? _selected;
  bool get selected => _selected ?? false;
  bool hasSelected() => _selected != null;

  // "documentId" field.
  String? _documentId;
  String get documentId => _documentId ?? '';
  bool hasDocumentId() => _documentId != null;

  // "linkedActivity" field.
  List<String>? _linkedActivity;
  List<String> get linkedActivity => _linkedActivity ?? const [];
  bool hasLinkedActivity() => _linkedActivity != null;

  // "linkedLinkedin" field.
  List<String>? _linkedLinkedin;
  List<String> get linkedLinkedin => _linkedLinkedin ?? const [];
  bool hasLinkedLinkedin() => _linkedLinkedin != null;

  // "linkedFb" field.
  List<String>? _linkedFb;
  List<String> get linkedFb => _linkedFb ?? const [];
  bool hasLinkedFb() => _linkedFb != null;

  // "linkedEmail" field.
  List<String>? _linkedEmail;
  List<String> get linkedEmail => _linkedEmail ?? const [];
  bool hasLinkedEmail() => _linkedEmail != null;

  // "linkedWhatsapp" field.
  List<String>? _linkedWhatsapp;
  List<String> get linkedWhatsapp => _linkedWhatsapp ?? const [];
  bool hasLinkedWhatsapp() => _linkedWhatsapp != null;

  // "linkedBlog" field.
  List<String>? _linkedBlog;
  List<String> get linkedBlog => _linkedBlog ?? const [];
  bool hasLinkedBlog() => _linkedBlog != null;

  // "linkedX" field.
  List<String>? _linkedX;
  List<String> get linkedX => _linkedX ?? const [];
  bool hasLinkedX() => _linkedX != null;

  // "companyOwner" field.
  String? _companyOwner;
  String get companyOwner => _companyOwner ?? '';
  bool hasCompanyOwner() => _companyOwner != null;

  // "userGenerated" field.
  String? _userGenerated;
  String get userGenerated => _userGenerated ?? '';
  bool hasUserGenerated() => _userGenerated != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _isFeatured = snapshotData['isFeatured'] as bool?;
    _item = snapshotData['item'] as String?;
    _source = snapshotData['source'] as String?;
    _selected = snapshotData['selected'] as bool?;
    _documentId = snapshotData['documentId'] as String?;
    _linkedActivity = getDataList(snapshotData['linkedActivity']);
    _linkedLinkedin = getDataList(snapshotData['linkedLinkedin']);
    _linkedFb = getDataList(snapshotData['linkedFb']);
    _linkedEmail = getDataList(snapshotData['linkedEmail']);
    _linkedWhatsapp = getDataList(snapshotData['linkedWhatsapp']);
    _linkedBlog = getDataList(snapshotData['linkedBlog']);
    _linkedX = getDataList(snapshotData['linkedX']);
    _companyOwner = snapshotData['companyOwner'] as String?;
    _userGenerated = snapshotData['userGenerated'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('awarenessDays');

  static Stream<AwarenessDaysRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AwarenessDaysRecord.fromSnapshot(s));

  static Future<AwarenessDaysRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AwarenessDaysRecord.fromSnapshot(s));

  static AwarenessDaysRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AwarenessDaysRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AwarenessDaysRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AwarenessDaysRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AwarenessDaysRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AwarenessDaysRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAwarenessDaysRecordData({
  DateTime? date,
  bool? isFeatured,
  String? item,
  String? source,
  bool? selected,
  String? documentId,
  String? companyOwner,
  String? userGenerated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'isFeatured': isFeatured,
      'item': item,
      'source': source,
      'selected': selected,
      'documentId': documentId,
      'companyOwner': companyOwner,
      'userGenerated': userGenerated,
    }.withoutNulls,
  );

  return firestoreData;
}

class AwarenessDaysRecordDocumentEquality
    implements Equality<AwarenessDaysRecord> {
  const AwarenessDaysRecordDocumentEquality();

  @override
  bool equals(AwarenessDaysRecord? e1, AwarenessDaysRecord? e2) {
    const listEquality = ListEquality();
    return e1?.date == e2?.date &&
        e1?.isFeatured == e2?.isFeatured &&
        e1?.item == e2?.item &&
        e1?.source == e2?.source &&
        e1?.selected == e2?.selected &&
        e1?.documentId == e2?.documentId &&
        listEquality.equals(e1?.linkedActivity, e2?.linkedActivity) &&
        listEquality.equals(e1?.linkedLinkedin, e2?.linkedLinkedin) &&
        listEquality.equals(e1?.linkedFb, e2?.linkedFb) &&
        listEquality.equals(e1?.linkedEmail, e2?.linkedEmail) &&
        listEquality.equals(e1?.linkedWhatsapp, e2?.linkedWhatsapp) &&
        listEquality.equals(e1?.linkedBlog, e2?.linkedBlog) &&
        listEquality.equals(e1?.linkedX, e2?.linkedX) &&
        e1?.companyOwner == e2?.companyOwner &&
        e1?.userGenerated == e2?.userGenerated;
  }

  @override
  int hash(AwarenessDaysRecord? e) => const ListEquality().hash([
        e?.date,
        e?.isFeatured,
        e?.item,
        e?.source,
        e?.selected,
        e?.documentId,
        e?.linkedActivity,
        e?.linkedLinkedin,
        e?.linkedFb,
        e?.linkedEmail,
        e?.linkedWhatsapp,
        e?.linkedBlog,
        e?.linkedX,
        e?.companyOwner,
        e?.userGenerated
      ]);

  @override
  bool isValidKey(Object? o) => o is AwarenessDaysRecord;
}
