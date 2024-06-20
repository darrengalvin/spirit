import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _selectedDate = prefs.containsKey('ff_selectedDate')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_selectedDate')!)
          : _selectedDate;
    });
    _safeInit(() {
      _showItem = prefs.getString('ff_showItem') ?? _showItem;
    });
    _safeInit(() {
      _fbSocialImage = prefs.getString('ff_fbSocialImage') ?? _fbSocialImage;
    });
    _safeInit(() {
      _fbUserName = prefs.getString('ff_fbUserName') ?? _fbUserName;
    });
    _safeInit(() {
      _selectedCompanyId =
          prefs.getString('ff_selectedCompanyId') ?? _selectedCompanyId;
    });
    _safeInit(() {
      _flowiseMessages = prefs
              .getStringList('ff_flowiseMessages')
              ?.map((x) {
                try {
                  return FlowiseMessagesStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _flowiseMessages;
    });
    _safeInit(() {
      _nonLoggedInSessionId =
          prefs.getString('ff_nonLoggedInSessionId') ?? _nonLoggedInSessionId;
    });
    _safeInit(() {
      _socketIOClientId =
          prefs.getString('ff_socketIOClientId') ?? _socketIOClientId;
    });
    _safeInit(() {
      _socketId = prefs.getString('ff_socketId') ?? _socketId;
    });
    _safeInit(() {
      _userChats = prefs
              .getStringList('ff_userChats')
              ?.map((x) {
                try {
                  return UserChatsStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _userChats;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _showActivityButton = false;
  bool get showActivityButton => _showActivityButton;
  set showActivityButton(bool value) {
    _showActivityButton = value;
  }

  String _selectedAwarenessDay = '';
  String get selectedAwarenessDay => _selectedAwarenessDay;
  set selectedAwarenessDay(String value) {
    _selectedAwarenessDay = value;
  }

  List<DateTime> _listOfMonths = [
    DateTime.fromMillisecondsSinceEpoch(1704152340000),
    DateTime.fromMillisecondsSinceEpoch(1706830740000),
    DateTime.fromMillisecondsSinceEpoch(1709336340000),
    DateTime.fromMillisecondsSinceEpoch(1712011140000),
    DateTime.fromMillisecondsSinceEpoch(1714603140000),
    DateTime.fromMillisecondsSinceEpoch(1717281600000),
    DateTime.fromMillisecondsSinceEpoch(1719873600000),
    DateTime.fromMillisecondsSinceEpoch(1722552000000),
    DateTime.fromMillisecondsSinceEpoch(1725230400000),
    DateTime.fromMillisecondsSinceEpoch(1727822400000),
    DateTime.fromMillisecondsSinceEpoch(1730504400000),
    DateTime.fromMillisecondsSinceEpoch(1733096400000)
  ];
  List<DateTime> get listOfMonths => _listOfMonths;
  set listOfMonths(List<DateTime> value) {
    _listOfMonths = value;
  }

  void addToListOfMonths(DateTime value) {
    listOfMonths.add(value);
  }

  void removeFromListOfMonths(DateTime value) {
    listOfMonths.remove(value);
  }

  void removeAtIndexFromListOfMonths(int index) {
    listOfMonths.removeAt(index);
  }

  void updateListOfMonthsAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    listOfMonths[index] = updateFn(_listOfMonths[index]);
  }

  void insertAtIndexInListOfMonths(int index, DateTime value) {
    listOfMonths.insert(index, value);
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
    value != null
        ? prefs.setInt('ff_selectedDate', value.millisecondsSinceEpoch)
        : prefs.remove('ff_selectedDate');
  }

  String _showItem = '';
  String get showItem => _showItem;
  set showItem(String value) {
    _showItem = value;
    prefs.setString('ff_showItem', value);
  }

  String _fbSocialImage =
      'https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png';
  String get fbSocialImage => _fbSocialImage;
  set fbSocialImage(String value) {
    _fbSocialImage = value;
    prefs.setString('ff_fbSocialImage', value);
  }

  String _fbUserName = 'Demo User Name';
  String get fbUserName => _fbUserName;
  set fbUserName(String value) {
    _fbUserName = value;
    prefs.setString('ff_fbUserName', value);
  }

  String _selectedMonth = '';
  String get selectedMonth => _selectedMonth;
  set selectedMonth(String value) {
    _selectedMonth = value;
  }

  List<ListOfAwarenessStruct> _awarenessDaysList = [];
  List<ListOfAwarenessStruct> get awarenessDaysList => _awarenessDaysList;
  set awarenessDaysList(List<ListOfAwarenessStruct> value) {
    _awarenessDaysList = value;
  }

  void addToAwarenessDaysList(ListOfAwarenessStruct value) {
    awarenessDaysList.add(value);
  }

  void removeFromAwarenessDaysList(ListOfAwarenessStruct value) {
    awarenessDaysList.remove(value);
  }

  void removeAtIndexFromAwarenessDaysList(int index) {
    awarenessDaysList.removeAt(index);
  }

  void updateAwarenessDaysListAtIndex(
    int index,
    ListOfAwarenessStruct Function(ListOfAwarenessStruct) updateFn,
  ) {
    awarenessDaysList[index] = updateFn(_awarenessDaysList[index]);
  }

  void insertAtIndexInAwarenessDaysList(
      int index, ListOfAwarenessStruct value) {
    awarenessDaysList.insert(index, value);
  }

  bool _showBasket = false;
  bool get showBasket => _showBasket;
  set showBasket(bool value) {
    _showBasket = value;
  }

  bool _editMode = false;
  bool get editMode => _editMode;
  set editMode(bool value) {
    _editMode = value;
  }

  String _selectedItem = '';
  String get selectedItem => _selectedItem;
  set selectedItem(String value) {
    _selectedItem = value;
  }

  bool _isSearchingActivities = false;
  bool get isSearchingActivities => _isSearchingActivities;
  set isSearchingActivities(bool value) {
    _isSearchingActivities = value;
  }

  bool _isCreatingFacebook = false;
  bool get isCreatingFacebook => _isCreatingFacebook;
  set isCreatingFacebook(bool value) {
    _isCreatingFacebook = value;
  }

  String _pageSelected = '';
  String get pageSelected => _pageSelected;
  set pageSelected(String value) {
    _pageSelected = value;
  }

  String _selectedNewsDay = '';
  String get selectedNewsDay => _selectedNewsDay;
  set selectedNewsDay(String value) {
    _selectedNewsDay = value;
  }

  String _selectedCompanyId = 'wh1sZDHws5iYvqMG2sUk';
  String get selectedCompanyId => _selectedCompanyId;
  set selectedCompanyId(String value) {
    _selectedCompanyId = value;
    prefs.setString('ff_selectedCompanyId', value);
  }

  bool _showDates = false;
  bool get showDates => _showDates;
  set showDates(bool value) {
    _showDates = value;
  }

  String _selectedTeam = 'ecRpgxwhQXtHwiBvFIr';
  String get selectedTeam => _selectedTeam;
  set selectedTeam(String value) {
    _selectedTeam = value;
  }

  String _sessionId = '';
  String get sessionId => _sessionId;
  set sessionId(String value) {
    _sessionId = value;
  }

  bool _isStreaming = false;
  bool get isStreaming => _isStreaming;
  set isStreaming(bool value) {
    _isStreaming = value;
  }

  bool _isStreamingComplete = false;
  bool get isStreamingComplete => _isStreamingComplete;
  set isStreamingComplete(bool value) {
    _isStreamingComplete = value;
  }

  List<FlowiseMessagesStruct> _flowiseMessages = [];
  List<FlowiseMessagesStruct> get flowiseMessages => _flowiseMessages;
  set flowiseMessages(List<FlowiseMessagesStruct> value) {
    _flowiseMessages = value;
    prefs.setStringList(
        'ff_flowiseMessages', value.map((x) => x.serialize()).toList());
  }

  void addToFlowiseMessages(FlowiseMessagesStruct value) {
    flowiseMessages.add(value);
    prefs.setStringList('ff_flowiseMessages',
        _flowiseMessages.map((x) => x.serialize()).toList());
  }

  void removeFromFlowiseMessages(FlowiseMessagesStruct value) {
    flowiseMessages.remove(value);
    prefs.setStringList('ff_flowiseMessages',
        _flowiseMessages.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromFlowiseMessages(int index) {
    flowiseMessages.removeAt(index);
    prefs.setStringList('ff_flowiseMessages',
        _flowiseMessages.map((x) => x.serialize()).toList());
  }

  void updateFlowiseMessagesAtIndex(
    int index,
    FlowiseMessagesStruct Function(FlowiseMessagesStruct) updateFn,
  ) {
    flowiseMessages[index] = updateFn(_flowiseMessages[index]);
    prefs.setStringList('ff_flowiseMessages',
        _flowiseMessages.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInFlowiseMessages(int index, FlowiseMessagesStruct value) {
    flowiseMessages.insert(index, value);
    prefs.setStringList('ff_flowiseMessages',
        _flowiseMessages.map((x) => x.serialize()).toList());
  }

  String _nonLoggedInSessionId = '';
  String get nonLoggedInSessionId => _nonLoggedInSessionId;
  set nonLoggedInSessionId(String value) {
    _nonLoggedInSessionId = value;
    prefs.setString('ff_nonLoggedInSessionId', value);
  }

  String _socketIOClientId = '';
  String get socketIOClientId => _socketIOClientId;
  set socketIOClientId(String value) {
    _socketIOClientId = value;
    prefs.setString('ff_socketIOClientId', value);
  }

  String _socketState = '';
  String get socketState => _socketState;
  set socketState(String value) {
    _socketState = value;
  }

  String _socketId = '';
  String get socketId => _socketId;
  set socketId(String value) {
    _socketId = value;
    prefs.setString('ff_socketId', value);
  }

  List<UserChatsStruct> _userChats = [];
  List<UserChatsStruct> get userChats => _userChats;
  set userChats(List<UserChatsStruct> value) {
    _userChats = value;
    prefs.setStringList(
        'ff_userChats', value.map((x) => x.serialize()).toList());
  }

  void addToUserChats(UserChatsStruct value) {
    userChats.add(value);
    prefs.setStringList(
        'ff_userChats', _userChats.map((x) => x.serialize()).toList());
  }

  void removeFromUserChats(UserChatsStruct value) {
    userChats.remove(value);
    prefs.setStringList(
        'ff_userChats', _userChats.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromUserChats(int index) {
    userChats.removeAt(index);
    prefs.setStringList(
        'ff_userChats', _userChats.map((x) => x.serialize()).toList());
  }

  void updateUserChatsAtIndex(
    int index,
    UserChatsStruct Function(UserChatsStruct) updateFn,
  ) {
    userChats[index] = updateFn(_userChats[index]);
    prefs.setStringList(
        'ff_userChats', _userChats.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInUserChats(int index, UserChatsStruct value) {
    userChats.insert(index, value);
    prefs.setStringList(
        'ff_userChats', _userChats.map((x) => x.serialize()).toList());
  }

  List<String> _tokens = [];
  List<String> get tokens => _tokens;
  set tokens(List<String> value) {
    _tokens = value;
  }

  void addToTokens(String value) {
    tokens.add(value);
  }

  void removeFromTokens(String value) {
    tokens.remove(value);
  }

  void removeAtIndexFromTokens(int index) {
    tokens.removeAt(index);
  }

  void updateTokensAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    tokens[index] = updateFn(_tokens[index]);
  }

  void insertAtIndexInTokens(int index, String value) {
    tokens.insert(index, value);
  }

  String _botMessageStream = '';
  String get botMessageStream => _botMessageStream;
  set botMessageStream(String value) {
    _botMessageStream = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
