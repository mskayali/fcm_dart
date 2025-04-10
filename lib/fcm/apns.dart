// ignore_for_file: public_member_api_docs


import 'package:google_services/fcm/apns_payload.dart';
import 'package:google_services/fcm/fcm_options.dart';

class Apns {

  Apns({
    this.headers,
    this.payload,
    this.fcmOptions,
  });

  factory Apns.fromJson(Map<String, dynamic> json) {
    return Apns(
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
      payload: json['payload'] != null && json['payload'] is Map<String,dynamic>  ? ApnsPayload.fromJson(json['payload'] as Map<String,dynamic>) : null,
      fcmOptions: json['fcm_options'] != null && json['fcm_options'] is Map<String,dynamic>  ? FcmOptions.fromJson(json['fcm_options'] as Map<String,dynamic>) : null,
    );
  }
  final Map<String, String>? headers;
  final ApnsPayload? payload;
  final FcmOptions? fcmOptions;

  Map<String, dynamic> toJson() {
    return {
      'headers': headers,
      'payload': payload?.toJson(),
      'fcm_options': fcmOptions?.toJson(),
    }..removeWhere((k, v) => v == null);
  }
}
