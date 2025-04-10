// ignore_for_file: public_member_api_docs, use_if_null_to_convert_nulls_to_bools

import 'package:google_services/fcm/aps_alert.dart';

class Aps {

  Aps({
    this.alert,
    this.alertDetails,
    this.badge,
    this.sound,
    this.category,
    this.threadId,
    this.contentAvailable,
    this.mutableContent,
    this.customData,
  });

  factory Aps.fromJson(Map<String, dynamic> json) {
    return Aps(
      alert: json['alert'] is String ? json['alert'].toString() : null,
      alertDetails: json['alert'] is Map<String, dynamic> ? ApsAlert.fromJson(json['alert'] as  Map<String, dynamic>) : null,
      badge: int.tryParse(json['badge'].toString()),
      sound: json['sound']?.toString(),
      category: json['category']?.toString(),
      threadId: json['thread-id']?.toString(),
      contentAvailable: bool.tryParse(json['content-available'].toString()),
      mutableContent: bool.tryParse(json['mutable-content'].toString()),
      customData: json
        ..removeWhere((key, value) =>
            ['alert', 'badge', 'sound', 'category', 'thread-id', 'content-available', 'mutable-content'].contains(key),), // Keeps additional custom data
    );
  }
  final String? alert;
  final ApsAlert? alertDetails;
  final int? badge;
  final String? sound;
  final String? category;
  final String? threadId;
  final bool? contentAvailable;
  final bool? mutableContent;
  final Map<String, dynamic>? customData;

  Map<String, dynamic> toJson() {
    final apsMap = {
      if (alertDetails != null) 'alert': alertDetails?.toJson() else 'alert': alert,
      'badge': badge,
      'sound': sound,
      'category': category,
      'thread-id': threadId,
      'content-available': contentAvailable == true ? 1 : null,
      'mutable-content': mutableContent == true ? 1 : null,
    }..removeWhere((k, v) => v == null);

    return {
      ...apsMap,
      ...?customData, // Includes any extra fields
    };
  }
}
