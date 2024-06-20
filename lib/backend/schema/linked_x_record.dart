import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LinkedXRecord extends FirestoreRecord {
  LinkedXRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "summary" field.
  String? _summary;
  String get summary => _summary ?? '';
  bool hasSummary() => _summary != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "dateposted" field.
  DateTime? _dateposted;
  DateTime? get dateposted => _dateposted;
  bool hasDateposted() => _dateposted != null;

  // "linkedAwarenessDay" field.
  String? _linkedAwarenessDay;
  String get linkedAwarenessDay => _linkedAwarenessDay ?? '';
  bool hasLinkedAwarenessDay() => _linkedAwarenessDay != null;

  // "fbDocId" field.
  String? _fbDocId;
  String get fbDocId => _fbDocId ?? '';
  bool hasFbDocId() => _fbDocId != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "main_text" field.
  String? _mainText;
  String get mainText => _mainText ?? '';
  bool hasMainText() => _mainText != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "associatedCompanyId" field.
  String? _associatedCompanyId;
  String get associatedCompanyId => _associatedCompanyId ?? '';
  bool hasAssociatedCompanyId() => _associatedCompanyId != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _summary = snapshotData['summary'] as String?;
    _description = snapshotData['description'] as String?;
    _dateposted = snapshotData['dateposted'] as DateTime?;
    _linkedAwarenessDay = snapshotData['linkedAwarenessDay'] as String?;
    _fbDocId = snapshotData['fbDocId'] as String?;
    _image = snapshotData['image'] as String?;
    _mainText = snapshotData['main_text'] as String?;
    _content = snapshotData['content'] as String?;
    _associatedCompanyId = snapshotData['associatedCompanyId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('linkedX');

  static Stream<LinkedXRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LinkedXRecord.fromSnapshot(s));

  static Future<LinkedXRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LinkedXRecord.fromSnapshot(s));

  static LinkedXRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LinkedXRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LinkedXRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LinkedXRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LinkedXRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LinkedXRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLinkedXRecordData({
  String? title,
  String? summary,
  String? description,
  DateTime? dateposted,
  String? linkedAwarenessDay,
  String? fbDocId,
  String? image,
  String? mainText,
  String? content,
  String? associatedCompanyId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'summary': summary,
      'description': description,
      'dateposted': dateposted,
      'linkedAwarenessDay': linkedAwarenessDay,
      'fbDocId': fbDocId,
      'image': image,
      'main_text': mainText,
      'content': content,
      'associatedCompanyId': associatedCompanyId,
    }.withoutNulls,
  );

  return firestoreData;
}

class LinkedXRecordDocumentEquality implements Equality<LinkedXRecord> {
  const LinkedXRecordDocumentEquality();

  @override
  bool equals(LinkedXRecord? e1, LinkedXRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.summary == e2?.summary &&
        e1?.description == e2?.description &&
        e1?.dateposted == e2?.dateposted &&
        e1?.linkedAwarenessDay == e2?.linkedAwarenessDay &&
        e1?.fbDocId == e2?.fbDocId &&
        e1?.image == e2?.image &&
        e1?.mainText == e2?.mainText &&
        e1?.content == e2?.content &&
        e1?.associatedCompanyId == e2?.associatedCompanyId;
  }

  @override
  int hash(LinkedXRecord? e) => const ListEquality().hash([
        e?.title,
        e?.summary,
        e?.description,
        e?.dateposted,
        e?.linkedAwarenessDay,
        e?.fbDocId,
        e?.image,
        e?.mainText,
        e?.content,
        e?.associatedCompanyId
      ]);

  @override
  bool isValidKey(Object? o) => o is LinkedXRecord;
}
