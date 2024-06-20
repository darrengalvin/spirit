// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TeachersStruct extends FFFirebaseStruct {
  TeachersStruct({
    String? teacherName,
    String? teacherEmail,
    String? teacherImage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _teacherName = teacherName,
        _teacherEmail = teacherEmail,
        _teacherImage = teacherImage,
        super(firestoreUtilData);

  // "teacherName" field.
  String? _teacherName;
  String get teacherName => _teacherName ?? '';
  set teacherName(String? val) => _teacherName = val;

  bool hasTeacherName() => _teacherName != null;

  // "teacherEmail" field.
  String? _teacherEmail;
  String get teacherEmail => _teacherEmail ?? '';
  set teacherEmail(String? val) => _teacherEmail = val;

  bool hasTeacherEmail() => _teacherEmail != null;

  // "teacherImage" field.
  String? _teacherImage;
  String get teacherImage => _teacherImage ?? '';
  set teacherImage(String? val) => _teacherImage = val;

  bool hasTeacherImage() => _teacherImage != null;

  static TeachersStruct fromMap(Map<String, dynamic> data) => TeachersStruct(
        teacherName: data['teacherName'] as String?,
        teacherEmail: data['teacherEmail'] as String?,
        teacherImage: data['teacherImage'] as String?,
      );

  static TeachersStruct? maybeFromMap(dynamic data) =>
      data is Map ? TeachersStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'teacherName': _teacherName,
        'teacherEmail': _teacherEmail,
        'teacherImage': _teacherImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'teacherName': serializeParam(
          _teacherName,
          ParamType.String,
        ),
        'teacherEmail': serializeParam(
          _teacherEmail,
          ParamType.String,
        ),
        'teacherImage': serializeParam(
          _teacherImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static TeachersStruct fromSerializableMap(Map<String, dynamic> data) =>
      TeachersStruct(
        teacherName: deserializeParam(
          data['teacherName'],
          ParamType.String,
          false,
        ),
        teacherEmail: deserializeParam(
          data['teacherEmail'],
          ParamType.String,
          false,
        ),
        teacherImage: deserializeParam(
          data['teacherImage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TeachersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TeachersStruct &&
        teacherName == other.teacherName &&
        teacherEmail == other.teacherEmail &&
        teacherImage == other.teacherImage;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([teacherName, teacherEmail, teacherImage]);
}

TeachersStruct createTeachersStruct({
  String? teacherName,
  String? teacherEmail,
  String? teacherImage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeachersStruct(
      teacherName: teacherName,
      teacherEmail: teacherEmail,
      teacherImage: teacherImage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TeachersStruct? updateTeachersStruct(
  TeachersStruct? teachers, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    teachers
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTeachersStructData(
  Map<String, dynamic> firestoreData,
  TeachersStruct? teachers,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (teachers == null) {
    return;
  }
  if (teachers.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && teachers.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final teachersData = getTeachersFirestoreData(teachers, forFieldValue);
  final nestedData = teachersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = teachers.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTeachersFirestoreData(
  TeachersStruct? teachers, [
  bool forFieldValue = false,
]) {
  if (teachers == null) {
    return {};
  }
  final firestoreData = mapToFirestore(teachers.toMap());

  // Add any Firestore field values
  teachers.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTeachersListFirestoreData(
  List<TeachersStruct>? teacherss,
) =>
    teacherss?.map((e) => getTeachersFirestoreData(e, true)).toList() ?? [];
