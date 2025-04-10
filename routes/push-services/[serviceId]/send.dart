// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:google_services/fcm/fcm_message.dart';
import 'package:google_services/fcm/service.dart';
import 'package:google_services/utils/models.dart';
Future<Response> onRequest(RequestContext context, String serviceId) async {
  if (context.request.method != HttpMethod.post) {
    return DefaultResponse(statusCode: 405, message: 'Method Not Allowed').json();
  }
  try {
    if(serviceId.isEmpty){
      return DefaultResponse(statusCode: 400, message: 'ServiceId is required').json();
    }
    final requestBody = await context.request.body();
    final data = json.decode(requestBody) as Map<String, dynamic>;
    if(data['tokens'] != null && data['tokens'] is List){
      final tokens = List<String>.from(data['tokens'] as List);
      data.remove('tokens');
      for (final e in tokens) {
        data['token']=e;
        unawaited(FirebaseService().sendNotification(serviceId, FcmMessage.fromJson(data)));
      }
      return DefaultResponse(
        message:'${tokens.length} token mesage has been sent to queue.',
      ).json();
    }else{
      unawaited(FirebaseService().sendNotification(serviceId, FcmMessage.fromJson(data)));
      return DefaultResponse(
        message: '1 token mesage has been sent to queue.',
      ).json();
    }


  } catch (e, s) {
    // ignore: avoid_print
    print('$e,$s');
    return DefaultResponse(
      message: 'Failure',
      statusCode: 422,
      data: '$e',
    ).json();
  }
}
