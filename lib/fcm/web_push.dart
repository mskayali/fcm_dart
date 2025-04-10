import 'package:google_services/fcm/fcm_options.dart';

class Webpush{

  Webpush({
    this.headers,
    this.data,
    this.notification,
    this.fcmOptions,
  });

  factory Webpush.fromJson(Map<String, dynamic> json) {
    return Webpush(
      notification: (json['notification'] != null && json['notification'] is Map<String, dynamic>) ? json['notification'] as Map<String, dynamic> : null,
      data: (json['data'] != null && json['data'] is Map<String, String>) ? json['data'] as Map<String, String> : null,
      headers: (json['headers'] != null && json['headers'] is Map<String, String>) ? json['headers'] as Map<String, String> : null,
      fcmOptions: (json['fcm_options'] != null && json['fcm_options'] is Map<String, dynamic>) ? FcmOptions.fromJson(json['fcm_options'] as Map<String, dynamic>) : null,
    );
  }
  Map<String,String>? headers;
  Map<String,String>? data;
  Map<String,dynamic>? notification;
  FcmOptions? fcmOptions;
  Map<String, dynamic> toJson() {
    return {
      'notification': notification,
      'data': data,
      'headers': headers,
      'fcm_options': fcmOptions?.toJson(),
    }..removeWhere((k, v) => v == null);
  }
}
