import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CompaniesRecord extends FirestoreRecord {
  CompaniesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "companyName" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "companyLogo" field.
  String? _companyLogo;
  String get companyLogo => _companyLogo ?? '';
  bool hasCompanyLogo() => _companyLogo != null;

  // "primaryColor" field.
  Color? _primaryColor;
  Color? get primaryColor => _primaryColor;
  bool hasPrimaryColor() => _primaryColor != null;

  // "secondaryColor" field.
  Color? _secondaryColor;
  Color? get secondaryColor => _secondaryColor;
  bool hasSecondaryColor() => _secondaryColor != null;

  // "primaryTextColor" field.
  Color? _primaryTextColor;
  Color? get primaryTextColor => _primaryTextColor;
  bool hasPrimaryTextColor() => _primaryTextColor != null;

  // "secondaryTextColor" field.
  Color? _secondaryTextColor;
  Color? get secondaryTextColor => _secondaryTextColor;
  bool hasSecondaryTextColor() => _secondaryTextColor != null;

  // "companyId" field.
  String? _companyId;
  String get companyId => _companyId ?? '';
  bool hasCompanyId() => _companyId != null;

  // "members" field.
  List<String>? _members;
  List<String> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "supabaseProjectUrl" field.
  String? _supabaseProjectUrl;
  String get supabaseProjectUrl => _supabaseProjectUrl ?? '';
  bool hasSupabaseProjectUrl() => _supabaseProjectUrl != null;

  // "flowiseUrl" field.
  String? _flowiseUrl;
  String get flowiseUrl => _flowiseUrl ?? '';
  bool hasFlowiseUrl() => _flowiseUrl != null;

  // "tableName" field.
  String? _tableName;
  String get tableName => _tableName ?? '';
  bool hasTableName() => _tableName != null;

  // "queryName" field.
  String? _queryName;
  String get queryName => _queryName ?? '';
  bool hasQueryName() => _queryName != null;

  // "supabaseApi" field.
  String? _supabaseApi;
  String get supabaseApi => _supabaseApi ?? '';
  bool hasSupabaseApi() => _supabaseApi != null;

  // "makeLink" field.
  String? _makeLink;
  String get makeLink => _makeLink ?? '';
  bool hasMakeLink() => _makeLink != null;

  // "licences" field.
  List<String>? _licences;
  List<String> get licences => _licences ?? const [];
  bool hasLicences() => _licences != null;

  // "nameForAiChat" field.
  String? _nameForAiChat;
  String get nameForAiChat => _nameForAiChat ?? '';
  bool hasNameForAiChat() => _nameForAiChat != null;

  // "promptForAiChat" field.
  String? _promptForAiChat;
  String get promptForAiChat => _promptForAiChat ?? '';
  bool hasPromptForAiChat() => _promptForAiChat != null;

  // "conversationPrompt" field.
  String? _conversationPrompt;
  String get conversationPrompt => _conversationPrompt ?? '';
  bool hasConversationPrompt() => _conversationPrompt != null;

  void _initializeFields() {
    _companyName = snapshotData['companyName'] as String?;
    _companyLogo = snapshotData['companyLogo'] as String?;
    _primaryColor = getSchemaColor(snapshotData['primaryColor']);
    _secondaryColor = getSchemaColor(snapshotData['secondaryColor']);
    _primaryTextColor = getSchemaColor(snapshotData['primaryTextColor']);
    _secondaryTextColor = getSchemaColor(snapshotData['secondaryTextColor']);
    _companyId = snapshotData['companyId'] as String?;
    _members = getDataList(snapshotData['members']);
    _supabaseProjectUrl = snapshotData['supabaseProjectUrl'] as String?;
    _flowiseUrl = snapshotData['flowiseUrl'] as String?;
    _tableName = snapshotData['tableName'] as String?;
    _queryName = snapshotData['queryName'] as String?;
    _supabaseApi = snapshotData['supabaseApi'] as String?;
    _makeLink = snapshotData['makeLink'] as String?;
    _licences = getDataList(snapshotData['licences']);
    _nameForAiChat = snapshotData['nameForAiChat'] as String?;
    _promptForAiChat = snapshotData['promptForAiChat'] as String?;
    _conversationPrompt = snapshotData['conversationPrompt'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('companies');

  static Stream<CompaniesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CompaniesRecord.fromSnapshot(s));

  static Future<CompaniesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CompaniesRecord.fromSnapshot(s));

  static CompaniesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CompaniesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CompaniesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CompaniesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CompaniesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CompaniesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCompaniesRecordData({
  String? companyName,
  String? companyLogo,
  Color? primaryColor,
  Color? secondaryColor,
  Color? primaryTextColor,
  Color? secondaryTextColor,
  String? companyId,
  String? supabaseProjectUrl,
  String? flowiseUrl,
  String? tableName,
  String? queryName,
  String? supabaseApi,
  String? makeLink,
  String? nameForAiChat,
  String? promptForAiChat,
  String? conversationPrompt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'companyName': companyName,
      'companyLogo': companyLogo,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'primaryTextColor': primaryTextColor,
      'secondaryTextColor': secondaryTextColor,
      'companyId': companyId,
      'supabaseProjectUrl': supabaseProjectUrl,
      'flowiseUrl': flowiseUrl,
      'tableName': tableName,
      'queryName': queryName,
      'supabaseApi': supabaseApi,
      'makeLink': makeLink,
      'nameForAiChat': nameForAiChat,
      'promptForAiChat': promptForAiChat,
      'conversationPrompt': conversationPrompt,
    }.withoutNulls,
  );

  return firestoreData;
}

class CompaniesRecordDocumentEquality implements Equality<CompaniesRecord> {
  const CompaniesRecordDocumentEquality();

  @override
  bool equals(CompaniesRecord? e1, CompaniesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.companyName == e2?.companyName &&
        e1?.companyLogo == e2?.companyLogo &&
        e1?.primaryColor == e2?.primaryColor &&
        e1?.secondaryColor == e2?.secondaryColor &&
        e1?.primaryTextColor == e2?.primaryTextColor &&
        e1?.secondaryTextColor == e2?.secondaryTextColor &&
        e1?.companyId == e2?.companyId &&
        listEquality.equals(e1?.members, e2?.members) &&
        e1?.supabaseProjectUrl == e2?.supabaseProjectUrl &&
        e1?.flowiseUrl == e2?.flowiseUrl &&
        e1?.tableName == e2?.tableName &&
        e1?.queryName == e2?.queryName &&
        e1?.supabaseApi == e2?.supabaseApi &&
        e1?.makeLink == e2?.makeLink &&
        listEquality.equals(e1?.licences, e2?.licences) &&
        e1?.nameForAiChat == e2?.nameForAiChat &&
        e1?.promptForAiChat == e2?.promptForAiChat &&
        e1?.conversationPrompt == e2?.conversationPrompt;
  }

  @override
  int hash(CompaniesRecord? e) => const ListEquality().hash([
        e?.companyName,
        e?.companyLogo,
        e?.primaryColor,
        e?.secondaryColor,
        e?.primaryTextColor,
        e?.secondaryTextColor,
        e?.companyId,
        e?.members,
        e?.supabaseProjectUrl,
        e?.flowiseUrl,
        e?.tableName,
        e?.queryName,
        e?.supabaseApi,
        e?.makeLink,
        e?.licences,
        e?.nameForAiChat,
        e?.promptForAiChat,
        e?.conversationPrompt
      ]);

  @override
  bool isValidKey(Object? o) => o is CompaniesRecord;
}
