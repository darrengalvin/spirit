// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//mport '/backend/supabase/supabase.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket; // Global reference to the socket.
List<String> tokens = [];
String botMessageStream = '';
bool isNewSession =
    true; // We assume true to start fresh when the app initiates.
StringBuffer messageBuffer = StringBuffer();
Future<void> socketManager(String? userId) async {
  // Initialize socket connection.

  socket = IO.io(
    'https://flowisedo.yourcaio.co.uk',
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );
  // Listening for the connect event from the socket
  socket?.on('connect', (_) {
    FFAppState().update(() {
      FFAppState().socketIOClientId = socket?.id ?? '';
    });
    print('Connected with socket ID: ${FFAppState().socketIOClientId}');
  });
  // Set up listeners for 'token', 'start', 'end', etc.

  socket?.on('token', (tokenData) {
    if (isNewSession) {
      messageBuffer.write(tokenData);
      tokens.add(tokenData);
      FFAppState().update(() {
        FFAppState().tokens = tokenData;
        FFAppState().userChats[0].message = messageBuffer.toString();
        FFAppState().botMessageStream = messageBuffer.toString();
      });
      print('Received token: $tokenData');
    }
  });

  socket?.on('start', (data) {
    // Handle start event. Perhaps indicate that a new session has begun.
    tokens.clear();
    isNewSession = true;
    print('New session started');

    UserChatsStruct newChat = UserChatsStruct(
      message: 'Welcome back',
      role: 'ai',
      timestamp: DateTime.now(),
    );
    List<UserChatsStruct> tempList = FFAppState().userChats;
    tempList.insert(0, newChat);
    // Add the newChat to the UserChatsList.
    FFAppState().update(() {
      FFAppState().userChats = tempList;
      FFAppState().socketState = 'BotMessageStart';
    });
  });

  socket?.on('end', (_) {
    // String fullMessage = tokens.join(' '); // Assuming space-separated tokens.
    String fullMessage = messageBuffer.toString();
    messageBuffer.clear(); // Clear the buffer for the next session.

    isNewSession = false;
    print('Full message: $fullMessage');
    FFAppState().update(() {
      // Now you can either update your UI with the full message or do additional operations.
      FFAppState().userChats = FFAppState().userChats;
      FFAppState().socketState = 'BotMessageEnd';
    });
  });
  // Handle error messages or connection issues.
  socket?.on('error', (errorData) {
    // Log the error or inform the user, depending on the error's nature.
    print('Socket Error: $errorData');
  });

  socket?.on('connect_error', (errorData) {
    print('Connection Error: $errorData');
  });

  socket?.on('disconnect', (_) {
    // Handle disconnects. Maybe attempt to reconnect or inform the user.
    print('Disconnected from server.');
  });

  // Connect the socket.
  socket?.connect();
}
