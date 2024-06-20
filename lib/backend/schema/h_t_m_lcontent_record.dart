import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HTMLcontentRecord extends FirestoreRecord {
  HTMLcontentRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

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

  // "htmlContent" field.
  String? _htmlContent;
  String get htmlContent => _htmlContent ?? '';
  bool hasHtmlContent() => _htmlContent != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "links" field.
  List<String>? _links;
  List<String> get links => _links ?? const [];
  bool hasLinks() => _links != null;

  // "additionalInfo" field.
  String? _additionalInfo;
  String get additionalInfo => _additionalInfo ?? '';
  bool hasAdditionalInfo() => _additionalInfo != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _createdTime = snapshotData['created_time'] as DateTime?;
    _title = snapshotData['title'] as String?;
    _summary = snapshotData['summary'] as String?;
    _description = snapshotData['description'] as String?;
    _htmlContent = snapshotData['htmlContent'] as String?;
    _userId = snapshotData['user_id'] as String?;
    _links = getDataList(snapshotData['links']);
    _additionalInfo = snapshotData['additionalInfo'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('HTMLcontent');

  static Stream<HTMLcontentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HTMLcontentRecord.fromSnapshot(s));

  static Future<HTMLcontentRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => HTMLcontentRecord.fromSnapshot(s));

  static HTMLcontentRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HTMLcontentRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HTMLcontentRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HTMLcontentRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HTMLcontentRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HTMLcontentRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHTMLcontentRecordData({
  DateTime? createdTime,
  String? title,
  String? summary,
  String? description,
  String? htmlContent,
  String? userId,
  String? additionalInfo,
  String? imageUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_time': createdTime,
      'title': title,
      'summary': summary,
      'description': description,
      'htmlContent': htmlContent,
      'user_id': userId,
      'additionalInfo': additionalInfo,
      'image_url': imageUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class HTMLcontentRecordDocumentEquality implements Equality<HTMLcontentRecord> {
  const HTMLcontentRecordDocumentEquality();

  @override
  bool equals(HTMLcontentRecord? e1, HTMLcontentRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdTime == e2?.createdTime &&
        e1?.title == e2?.title &&
        e1?.summary == e2?.summary &&
        e1?.description == e2?.description &&
        e1?.htmlContent == e2?.htmlContent &&
        e1?.userId == e2?.userId &&
        listEquality.equals(e1?.links, e2?.links) &&
        e1?.additionalInfo == e2?.additionalInfo &&
        e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(HTMLcontentRecord? e) => const ListEquality().hash([
        e?.createdTime,
        e?.title,
        e?.summary,
        e?.description,
        e?.htmlContent,
        e?.userId,
        e?.links,
        e?.additionalInfo,
        e?.imageUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is HTMLcontentRecord;
}
