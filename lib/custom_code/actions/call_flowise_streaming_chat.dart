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

//import '/backend/supabase/supabase.dart';
//import '/actions/actions.dart' as action_blocks;

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

Future callFlowiseStreamingChat(
  String? question,
  String? systemPrompt,
  String? systemMessagePrompt,
  String? shopId,
  String? inputKey,
  String? outputKey,
  String? supabaseProjUrl,
  String? tableName,
  String? supabaseApiKey,
  String? queryName,
  bool? isLearnCards,
  int? maxTokens,
  Future<dynamic> Function()? callbackAction,
  Future<dynamic> Function() streamingCompleteAtion,
  String? supabaseMetadataFilter,
) async {
  // Initialize Socket.IO client
  IO.Socket socket =
      IO.io('https://flowisedo.yourcaio.co.uk', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  // Listen to Socket.IO events
  socket.on('start', (_) => print('WebSocket event: start'));

  // Variable to add each new token to
  String incomingTokens = '';

  FlowiseMessagesStruct currentMessage = FlowiseMessagesStruct(
    message: "Thinking...",
    role: 'ai',
  );
  print('Generated Struct');

  // Add currentMessage to the AppState
  FFAppState().flowiseMessages.add(currentMessage);

  // Set isStreamingComplete to false when starting a new streaming session
  FFAppState().update(() {
    FFAppState().isStreamingComplete = false;
    print('isStreamingComplete set to false');
  });

  socket.on('token', (token) {
    print('WebSocket event: token: $token');
    // Accumulate tokens in incomingTokens
    incomingTokens += '$token';

    // Update the message of currentMessage in AppState
    FFAppState().update(() {
      // Find the current message in AppState and update its content
      int indexToUpdate = FFAppState().flowiseMessages.indexOf(currentMessage);
      if (indexToUpdate != -1) {
        FFAppState().flowiseMessages[indexToUpdate].message = incomingTokens;
      }
    });

    print('Adding tokens');

    // Callback action used to scroll by update UI
    callbackAction!();
  });

  socket.on(
      'sourceDocuments',
      (sourceDocuments) =>
          print('WebSocket event: sourceDocuments: $sourceDocuments'));
  socket.on('end', (_) {
    print('WebSocket event: end');
    // Set isStreamingComplete to true when the streaming is complete
    FFAppState().update(() {
      FFAppState().isStreamingComplete = true;
      print('isStreamingComplete set to true');
    });
  });

  // Connect to Socket.IO
  socket.connect();

  // Wait for connection to be established
  await Future.delayed(Duration(seconds: 2));

  // Define override config
  Map<String, dynamic> overrideConfig = {
    "sessionId": FFAppState().nonLoggedInSessionId,
    "systemMessagePrompt": systemMessagePrompt,
    "systemPrompt": systemPrompt,
    "supabaseMetadataFilter": {"type": supabaseMetadataFilter}
  };

  // Check if the user's message is null
  if (question == null) {
    print("User message is null. Aborting.");
    return '';
  }

  // Prepare the payload for the API call
  var body = json.encode({
    'question': question,
    'socketIOClientId': socket.id,
    'overrideConfig': overrideConfig,
    'inputKey': inputKey,
    'outputKey': outputKey,
    'supabaseProjUrl': supabaseProjUrl,
    'tableName': tableName,
    'supabaseApiKey': supabaseApiKey,
    'queryName': queryName,
    'isLearnCards': isLearnCards,
    'maxTokens': maxTokens
  });

  // Send message to Flowise API
  try {
    var response = await http.post(
      Uri.parse(
          'https://yourcaio.co.uk:8445/api/v1/prediction/ba6576fd-0766-4399-8039-c1822a28ba1f'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String message = data['text'] ?? 'No message provided';
      List<int> productIdsList = [];
      if (data['sourceDocuments'] != null) {
        for (var doc in data['sourceDocuments']) {
          if (doc['metadata'] != null &&
              doc['metadata']['product_id'] != null) {
            productIdsList.add(doc['metadata']['product_id']);
          }
        }
      }

      // Create a new FlowiseMessagesStruct
      FlowiseMessagesStruct currentMessage = FlowiseMessagesStruct(
        message: message,
        role: 'ai',
      );

      // Call this to mark streaming as done
      streamingCompleteAtion();

      // Delete the last message in the flowiseMessages appState
      FFAppState().update(() {
        FFAppState().flowiseMessages.removeLast();
      });

      // Add newMessage to the AppState
      FFAppState().update(() {
        FFAppState().flowiseMessages.add(currentMessage);
      });

      // Call this to mark streaming as done
      streamingCompleteAtion();

      // Set isStreamingComplete to true when the streaming is complete
      FFAppState().update(() {
        FFAppState().isStreamingComplete = true;
        print('isStreamingComplete set to true');
      });

      return message;
    } else {
      print("Failed to send the message. Status Code: ${response.statusCode}");
      print("Response body: ${response.body}");
      // Handle error based on the status code or error message
      throw Exception(
          'Failed to send the message. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error occurred while sending the message: $error');
    // Handle the error gracefully, e.g., show an error message to the user
    return 'An error occurred. Please try again later.';
  } finally {
    // Disconnect the Socket.IO connection
    socket.disconnect();
    print('Socket disconnected');
  }
}
