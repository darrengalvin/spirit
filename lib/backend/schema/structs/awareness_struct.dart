// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AwarenessStruct extends FFFirebaseStruct {
  AwarenessStruct({
    String? awarenessDay,
    String? awarenessIdString,
    DateTime? awarenessdate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _awarenessDay = awarenessDay,
        _awarenessIdString = awarenessIdString,
        _awarenessdate = awarenessdate,
        super(firestoreUtilData);

  // "awarenessDay" field.
  String? _awarenessDay;
  String get awarenessDay => _awarenessDay ?? '';
  set awarenessDay(String? val) => _awarenessDay = val;

  bool hasAwarenessDay() => _awarenessDay != null;

  // "awarenessIdString" field.
  String? _awarenessIdString;
  String get awarenessIdString => _awarenessIdString ?? '';
  set awarenessIdString(String? val) => _awarenessIdString = val;

  bool hasAwarenessIdString() => _awarenessIdString != null;

  // "awarenessdate" field.
  DateTime? _awarenessdate;
  DateTime? get awarenessdate => _awarenessdate;
  set awarenessdate(DateTime? val) => _awarenessdate = val;

  bool hasAwarenessdate() => _awarenessdate != null;

  static AwarenessStruct fromMap(Map<String, dynamic> data) => AwarenessStruct(
        awarenessDay: data['awarenessDay'] as String?,
        awarenessIdString: data['awarenessIdString'] as String?,
        awarenessdate: data['awarenessdate'] as DateTime?,
      );

  static AwarenessStruct? maybeFromMap(dynamic data) => data is Map
      ? AwarenessStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'awarenessDay': _awarenessDay,
        'awarenessIdString': _awarenessIdString,
        'awarenessdate': _awarenessdate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'awarenessDay': serializeParam(
          _awarenessDay,
          ParamType.String,
        ),
        'awarenessIdString': serializeParam(
          _awarenessIdString,
          ParamType.String,
        ),
        'awarenessdate': serializeParam(
          _awarenessdate,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static AwarenessStruct fromSerializableMap(Map<String, dynamic> data) =>
      AwarenessStruct(
        awarenessDay: deserializeParam(
          data['awarenessDay'],
          ParamType.String,
          false,
        ),
        awarenessIdString: deserializeParam(
          data['awarenessIdString'],
          ParamType.String,
          false,
        ),
        awarenessdate: deserializeParam(
          data['awarenessdate'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'AwarenessStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AwarenessStruct &&
        awarenessDay == other.awarenessDay &&
        awarenessIdString == other.awarenessIdString &&
        awarenessdate == other.awarenessdate;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([awarenessDay, awarenessIdString, awarenessdate]);
}

AwarenessStruct createAwarenessStruct({
  String? awarenessDay,
  String? awarenessIdString,
  DateTime? awarenessdate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AwarenessStruct(
      awarenessDay: awarenessDay,
      awarenessIdString: awarenessIdString,
      awarenessdate: awarenessdate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AwarenessStruct? updateAwarenessStruct(
  AwarenessStruct? awareness, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    awareness
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAwarenessStructData(
  Map<String, dynamic> firestoreData,
  AwarenessStruct? awareness,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (awareness == null) {
    return;
  }
  if (awareness.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && awareness.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final awarenessData = getAwarenessFirestoreData(awareness, forFieldValue);
  final nestedData = awarenessData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = awareness.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAwarenessFirestoreData(
  AwarenessStruct? awareness, [
  bool forFieldValue = false,
]) {
  if (awareness == null) {
    return {};
  }
  final firestoreData = mapToFirestore(awareness.toMap());

  // Add any Firestore field values
  awareness.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAwarenessListFirestoreData(
  List<AwarenessStruct>? awarenesss,
) =>
    awarenesss?.map((e) => getAwarenessFirestoreData(e, true)).toList() ?? [];
