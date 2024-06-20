import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "fbSocialImage" field.
  String? _fbSocialImage;
  String get fbSocialImage => _fbSocialImage ?? '';
  bool hasFbSocialImage() => _fbSocialImage != null;

  // "associatedCompanyId" field.
  String? _associatedCompanyId;
  String get associatedCompanyId => _associatedCompanyId ?? '';
  bool hasAssociatedCompanyId() => _associatedCompanyId != null;

  // "defaultThreadId" field.
  String? _defaultThreadId;
  String get defaultThreadId => _defaultThreadId ?? '';
  bool hasDefaultThreadId() => _defaultThreadId != null;

  // "diaryThread" field.
  String? _diaryThread;
  String get diaryThread => _diaryThread ?? '';
  bool hasDiaryThread() => _diaryThread != null;

  // "chatsLastSync" field.
  DateTime? _chatsLastSync;
  DateTime? get chatsLastSync => _chatsLastSync;
  bool hasChatsLastSync() => _chatsLastSync != null;

  // "isAdmin" field.
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;
  bool hasIsAdmin() => _isAdmin != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _fbSocialImage = snapshotData['fbSocialImage'] as String?;
    _associatedCompanyId = snapshotData['associatedCompanyId'] as String?;
    _defaultThreadId = snapshotData['defaultThreadId'] as String?;
    _diaryThread = snapshotData['diaryThread'] as String?;
    _chatsLastSync = snapshotData['chatsLastSync'] as DateTime?;
    _isAdmin = snapshotData['isAdmin'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? fbSocialImage,
  String? associatedCompanyId,
  String? defaultThreadId,
  String? diaryThread,
  DateTime? chatsLastSync,
  bool? isAdmin,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'fbSocialImage': fbSocialImage,
      'associatedCompanyId': associatedCompanyId,
      'defaultThreadId': defaultThreadId,
      'diaryThread': diaryThread,
      'chatsLastSync': chatsLastSync,
      'isAdmin': isAdmin,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.fbSocialImage == e2?.fbSocialImage &&
        e1?.associatedCompanyId == e2?.associatedCompanyId &&
        e1?.defaultThreadId == e2?.defaultThreadId &&
        e1?.diaryThread == e2?.diaryThread &&
        e1?.chatsLastSync == e2?.chatsLastSync &&
        e1?.isAdmin == e2?.isAdmin;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.fbSocialImage,
        e?.associatedCompanyId,
        e?.defaultThreadId,
        e?.diaryThread,
        e?.chatsLastSync,
        e?.isAdmin
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
