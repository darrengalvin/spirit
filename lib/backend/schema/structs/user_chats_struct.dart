// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserChatsStruct extends FFFirebaseStruct {
  UserChatsStruct({
    String? message,
    String? role,
    DateTime? timestamp,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _message = message,
        _role = role,
        _timestamp = timestamp,
        super(firestoreUtilData);

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  set timestamp(DateTime? val) => _timestamp = val;

  bool hasTimestamp() => _timestamp != null;

  static UserChatsStruct fromMap(Map<String, dynamic> data) => UserChatsStruct(
        message: data['message'] as String?,
        role: data['role'] as String?,
        timestamp: data['timestamp'] as DateTime?,
      );

  static UserChatsStruct? maybeFromMap(dynamic data) => data is Map
      ? UserChatsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'message': _message,
        'role': _role,
        'timestamp': _timestamp,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static UserChatsStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserChatsStruct(
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
        timestamp: deserializeParam(
          data['timestamp'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'UserChatsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserChatsStruct &&
        message == other.message &&
        role == other.role &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode => const ListEquality().hash([message, role, timestamp]);
}

UserChatsStruct createUserChatsStruct({
  String? message,
  String? role,
  DateTime? timestamp,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserChatsStruct(
      message: message,
      role: role,
      timestamp: timestamp,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserChatsStruct? updateUserChatsStruct(
  UserChatsStruct? userChats, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userChats
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserChatsStructData(
  Map<String, dynamic> firestoreData,
  UserChatsStruct? userChats,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userChats == null) {
    return;
  }
  if (userChats.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userChats.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userChatsData = getUserChatsFirestoreData(userChats, forFieldValue);
  final nestedData = userChatsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userChats.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserChatsFirestoreData(
  UserChatsStruct? userChats, [
  bool forFieldValue = false,
]) {
  if (userChats == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userChats.toMap());

  // Add any Firestore field values
  userChats.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserChatsListFirestoreData(
  List<UserChatsStruct>? userChatss,
) =>
    userChatss?.map((e) => getUserChatsFirestoreData(e, true)).toList() ?? [];
