import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SocialConnectionsRecord extends FirestoreRecord {
  SocialConnectionsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "socialName" field.
  String? _socialName;
  String get socialName => _socialName ?? '';
  bool hasSocialName() => _socialName != null;

  // "socialDescription" field.
  String? _socialDescription;
  String get socialDescription => _socialDescription ?? '';
  bool hasSocialDescription() => _socialDescription != null;

  // "socialIcon" field.
  String? _socialIcon;
  String get socialIcon => _socialIcon ?? '';
  bool hasSocialIcon() => _socialIcon != null;

  // "socialConnectionString" field.
  String? _socialConnectionString;
  String get socialConnectionString => _socialConnectionString ?? '';
  bool hasSocialConnectionString() => _socialConnectionString != null;

  // "socialHandle" field.
  String? _socialHandle;
  String get socialHandle => _socialHandle ?? '';
  bool hasSocialHandle() => _socialHandle != null;

  // "socialImage" field.
  String? _socialImage;
  String get socialImage => _socialImage ?? '';
  bool hasSocialImage() => _socialImage != null;

  // "connected" field.
  bool? _connected;
  bool get connected => _connected ?? false;
  bool hasConnected() => _connected != null;

  // "associatedCompanyId" field.
  String? _associatedCompanyId;
  String get associatedCompanyId => _associatedCompanyId ?? '';
  bool hasAssociatedCompanyId() => _associatedCompanyId != null;

  void _initializeFields() {
    _socialName = snapshotData['socialName'] as String?;
    _socialDescription = snapshotData['socialDescription'] as String?;
    _socialIcon = snapshotData['socialIcon'] as String?;
    _socialConnectionString = snapshotData['socialConnectionString'] as String?;
    _socialHandle = snapshotData['socialHandle'] as String?;
    _socialImage = snapshotData['socialImage'] as String?;
    _connected = snapshotData['connected'] as bool?;
    _associatedCompanyId = snapshotData['associatedCompanyId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('socialConnections');

  static Stream<SocialConnectionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SocialConnectionsRecord.fromSnapshot(s));

  static Future<SocialConnectionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => SocialConnectionsRecord.fromSnapshot(s));

  static SocialConnectionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SocialConnectionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SocialConnectionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SocialConnectionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SocialConnectionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SocialConnectionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSocialConnectionsRecordData({
  String? socialName,
  String? socialDescription,
  String? socialIcon,
  String? socialConnectionString,
  String? socialHandle,
  String? socialImage,
  bool? connected,
  String? associatedCompanyId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'socialName': socialName,
      'socialDescription': socialDescription,
      'socialIcon': socialIcon,
      'socialConnectionString': socialConnectionString,
      'socialHandle': socialHandle,
      'socialImage': socialImage,
      'connected': connected,
      'associatedCompanyId': associatedCompanyId,
    }.withoutNulls,
  );

  return firestoreData;
}

class SocialConnectionsRecordDocumentEquality
    implements Equality<SocialConnectionsRecord> {
  const SocialConnectionsRecordDocumentEquality();

  @override
  bool equals(SocialConnectionsRecord? e1, SocialConnectionsRecord? e2) {
    return e1?.socialName == e2?.socialName &&
        e1?.socialDescription == e2?.socialDescription &&
        e1?.socialIcon == e2?.socialIcon &&
        e1?.socialConnectionString == e2?.socialConnectionString &&
        e1?.socialHandle == e2?.socialHandle &&
        e1?.socialImage == e2?.socialImage &&
        e1?.connected == e2?.connected &&
        e1?.associatedCompanyId == e2?.associatedCompanyId;
  }

  @override
  int hash(SocialConnectionsRecord? e) => const ListEquality().hash([
        e?.socialName,
        e?.socialDescription,
        e?.socialIcon,
        e?.socialConnectionString,
        e?.socialHandle,
        e?.socialImage,
        e?.connected,
        e?.associatedCompanyId
      ]);

  @override
  bool isValidKey(Object? o) => o is SocialConnectionsRecord;
}
