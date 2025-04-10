// ignore_for_file: public_member_api_docs

import 'package:google_services/fcm/apns.dart';
import 'package:google_services/fcm/fcm_android.dart';
import 'package:google_services/fcm/fcm_data.dart';
import 'package:google_services/fcm/fcm_notification.dart';
import 'package:google_services/fcm/web_push.dart';

class FcmMessage {

  FcmMessage({
    this.notification,
    this.data,
    this.android,
    this.apns,
    this.token,
    this.webpush,
    this.topic,
    this.condition,
  });

  factory FcmMessage.fromJson(Map<String, dynamic> json) {
    return FcmMessage(
      notification: (json['notification'] != null && json['notification'] is Map<String,dynamic> ) ? FcmNotification.fromJson(json['notification'] as Map<String,dynamic>) : null,
      data: (json['data'] != null && json['data'] is Map<String,dynamic> ) ? FcmData.fromJson(json['data'] as Map<String,dynamic>) : null,
      android: (json['android'] != null && json['android'] is Map<String,dynamic> ) ? FcmAndroid.fromJson(json['android'] as Map<String,dynamic>) : null,
      apns: (json['apns'] != null && json['apns'] is Map<String,dynamic> ) ? Apns.fromJson(json['apns'] as Map<String,dynamic>) : null,
      token: json['token']?.toString(),
      webpush: (json['webpush'] != null && json['webpush'] is Map<String, dynamic>) ? Webpush.fromJson(json['webpush'] as Map<String, dynamic>) : null,
      topic: json['topic']?.toString(),
      condition: json['condition']?.toString(),
    );
  }
  final FcmNotification? notification;
  final FcmData? data;
  final FcmAndroid? android;
  final Apns? apns;
  final String? token;
  final Webpush? webpush;
  final String? topic;
  final String? condition;

  Map<String, dynamic> toJson() {
    return {
      'notification': notification?.toJson(),
      'data': data?.toJson(),
      'android': android?.toJson(),
      'apns': apns?.toJson(),
      'token': token,
      'webpush': webpush?.toJson(),
      'topic': topic,
      'condition': condition,
    }..removeWhere((k, v) => v == null);
  }
}
