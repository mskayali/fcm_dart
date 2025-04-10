// ignore_for_file: public_member_api_docs
import 'package:google_services/fcm/fcm_android_notification.dart';
import 'package:google_services/fcm/fcm_options.dart';

/// A class for sending Firebase Cloud Messaging (FCM) messages to Android devices.
class FcmAndroid {

  FcmAndroid({
    this.collapseKey,
    this.priority,
    this.ttl,
    this.restrictedPackageName,
    this.data,
    this.notification,
    this.fcmOptions,
  });

  factory FcmAndroid.fromJson(Map<String, dynamic> json) {
    return FcmAndroid(
      collapseKey: json['collapse_key']?.toString(),
      priority: json['priority']?.toString(),
      ttl: json['ttl']?.toString(),
      restrictedPackageName: json['restricted_package_name']?.toString(),
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
      notification: (json['notification'] != null && json['notification'] is Map<String,dynamic>)
          ? FcmAndroidNotification.fromJson(json['notification'] as Map<String,dynamic>)
          : null,
      fcmOptions: (json['fcm_options'] != null && json['fcm_options'] is Map<String,dynamic>)
          ? FcmOptions.fromJson(json['fcm_options'] as Map<String,dynamic>)
          : null,
    );
  }
  final String? collapseKey;
  final String? priority;
  final String? ttl;
  final String? restrictedPackageName;
  final Map<String, String>? data;
  final FcmAndroidNotification? notification;
  final FcmOptions? fcmOptions;

  Map<String, dynamic> toJson() {
    return {
      'collapse_key': collapseKey,
      'priority': priority,
      'ttl': ttl,
      'restricted_package_name': restrictedPackageName,
      'data': data,
      'notification': notification?.toJson(),
      'fcm_options': fcmOptions?.toJson(),
    }..removeWhere((k, v) => v == null);
  }
}
