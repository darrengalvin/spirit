// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FlowiseMessagesStruct extends FFFirebaseStruct {
  FlowiseMessagesStruct({
    String? message,
    String? role,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _message = message,
        _role = role,
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

  static FlowiseMessagesStruct fromMap(Map<String, dynamic> data) =>
      FlowiseMessagesStruct(
        message: data['message'] as String?,
        role: data['role'] as String?,
      );

  static FlowiseMessagesStruct? maybeFromMap(dynamic data) => data is Map
      ? FlowiseMessagesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'message': _message,
        'role': _role,
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
      }.withoutNulls;

  static FlowiseMessagesStruct fromSerializableMap(Map<String, dynamic> data) =>
      FlowiseMessagesStruct(
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
      );

  @override
  String toString() => 'FlowiseMessagesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FlowiseMessagesStruct &&
        message == other.message &&
        role == other.role;
  }

  @override
  int get hashCode => const ListEquality().hash([message, role]);
}

FlowiseMessagesStruct createFlowiseMessagesStruct({
  String? message,
  String? role,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FlowiseMessagesStruct(
      message: message,
      role: role,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FlowiseMessagesStruct? updateFlowiseMessagesStruct(
  FlowiseMessagesStruct? flowiseMessages, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    flowiseMessages
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFlowiseMessagesStructData(
  Map<String, dynamic> firestoreData,
  FlowiseMessagesStruct? flowiseMessages,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (flowiseMessages == null) {
    return;
  }
  if (flowiseMessages.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && flowiseMessages.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final flowiseMessagesData =
      getFlowiseMessagesFirestoreData(flowiseMessages, forFieldValue);
  final nestedData =
      flowiseMessagesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = flowiseMessages.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFlowiseMessagesFirestoreData(
  FlowiseMessagesStruct? flowiseMessages, [
  bool forFieldValue = false,
]) {
  if (flowiseMessages == null) {
    return {};
  }
  final firestoreData = mapToFirestore(flowiseMessages.toMap());

  // Add any Firestore field values
  flowiseMessages.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFlowiseMessagesListFirestoreData(
  List<FlowiseMessagesStruct>? flowiseMessagess,
) =>
    flowiseMessagess
        ?.map((e) => getFlowiseMessagesFirestoreData(e, true))
        .toList() ??
    [];
