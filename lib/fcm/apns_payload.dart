// ignore_for_file: public_member_api_docs

import 'package:google_services/fcm/aps.dart';

class ApnsPayload {

  ApnsPayload({
    this.aps,
    this.customData,
  });

  factory ApnsPayload.fromJson(Map<String, dynamic> json) {
    return ApnsPayload(
      aps: (json['aps'] != null && json['aps'] is Map<String,dynamic>) ? Aps.fromJson(json['aps'] as Map<String, dynamic>) : null,
      customData: json..remove('aps'), // Keeps additional custom data
    );
  }
  final Aps? aps;
  final Map<String, dynamic>? customData;

  Map<String, dynamic> toJson() {
    return {
      'aps': (aps?.toJson()?..removeWhere((k,v)=>v == null)) ?? {},
      ...?customData, // Merges custom data if available
    };
  }
}
