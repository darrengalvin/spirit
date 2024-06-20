// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ListOfAwarenessStruct extends FFFirebaseStruct {
  ListOfAwarenessStruct({
    DateTime? date,
    String? documentId,
    bool? isFeatured,
    String? item,
    String? source,
    bool? selected,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _documentId = documentId,
        _isFeatured = isFeatured,
        _item = item,
        _source = source,
        _selected = selected,
        super(firestoreUtilData);

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "documentId" field.
  String? _documentId;
  String get documentId => _documentId ?? '';
  set documentId(String? val) => _documentId = val;

  bool hasDocumentId() => _documentId != null;

  // "isFeatured" field.
  bool? _isFeatured;
  bool get isFeatured => _isFeatured ?? false;
  set isFeatured(bool? val) => _isFeatured = val;

  bool hasIsFeatured() => _isFeatured != null;

  // "item" field.
  String? _item;
  String get item => _item ?? '';
  set item(String? val) => _item = val;

  bool hasItem() => _item != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  set source(String? val) => _source = val;

  bool hasSource() => _source != null;

  // "selected" field.
  bool? _selected;
  bool get selected => _selected ?? false;
  set selected(bool? val) => _selected = val;

  bool hasSelected() => _selected != null;

  static ListOfAwarenessStruct fromMap(Map<String, dynamic> data) =>
      ListOfAwarenessStruct(
        date: data['date'] as DateTime?,
        documentId: data['documentId'] as String?,
        isFeatured: data['isFeatured'] as bool?,
        item: data['item'] as String?,
        source: data['source'] as String?,
        selected: data['selected'] as bool?,
      );

  static ListOfAwarenessStruct? maybeFromMap(dynamic data) => data is Map
      ? ListOfAwarenessStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'documentId': _documentId,
        'isFeatured': _isFeatured,
        'item': _item,
        'source': _source,
        'selected': _selected,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'documentId': serializeParam(
          _documentId,
          ParamType.String,
        ),
        'isFeatured': serializeParam(
          _isFeatured,
          ParamType.bool,
        ),
        'item': serializeParam(
          _item,
          ParamType.String,
        ),
        'source': serializeParam(
          _source,
          ParamType.String,
        ),
        'selected': serializeParam(
          _selected,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ListOfAwarenessStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListOfAwarenessStruct(
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        documentId: deserializeParam(
          data['documentId'],
          ParamType.String,
          false,
        ),
        isFeatured: deserializeParam(
          data['isFeatured'],
          ParamType.bool,
          false,
        ),
        item: deserializeParam(
          data['item'],
          ParamType.String,
          false,
        ),
        source: deserializeParam(
          data['source'],
          ParamType.String,
          false,
        ),
        selected: deserializeParam(
          data['selected'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ListOfAwarenessStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ListOfAwarenessStruct &&
        date == other.date &&
        documentId == other.documentId &&
        isFeatured == other.isFeatured &&
        item == other.item &&
        source == other.source &&
        selected == other.selected;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([date, documentId, isFeatured, item, source, selected]);
}

ListOfAwarenessStruct createListOfAwarenessStruct({
  DateTime? date,
  String? documentId,
  bool? isFeatured,
  String? item,
  String? source,
  bool? selected,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListOfAwarenessStruct(
      date: date,
      documentId: documentId,
      isFeatured: isFeatured,
      item: item,
      source: source,
      selected: selected,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListOfAwarenessStruct? updateListOfAwarenessStruct(
  ListOfAwarenessStruct? listOfAwareness, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listOfAwareness
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListOfAwarenessStructData(
  Map<String, dynamic> firestoreData,
  ListOfAwarenessStruct? listOfAwareness,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listOfAwareness == null) {
    return;
  }
  if (listOfAwareness.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listOfAwareness.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listOfAwarenessData =
      getListOfAwarenessFirestoreData(listOfAwareness, forFieldValue);
  final nestedData =
      listOfAwarenessData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listOfAwareness.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListOfAwarenessFirestoreData(
  ListOfAwarenessStruct? listOfAwareness, [
  bool forFieldValue = false,
]) {
  if (listOfAwareness == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listOfAwareness.toMap());

  // Add any Firestore field values
  listOfAwareness.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListOfAwarenessListFirestoreData(
  List<ListOfAwarenessStruct>? listOfAwarenesss,
) =>
    listOfAwarenesss
        ?.map((e) => getListOfAwarenessFirestoreData(e, true))
        .toList() ??
    [];
