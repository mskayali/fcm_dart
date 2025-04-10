// ignore_for_file: public_member_api_docs

import 'package:google_services/fcm/color_rgb.dart';


/// Represents the light settings for a light fixture.
class LightSettings {

  LightSettings({
    this.color,
    this.lightOnDuration,
    this.lightOffDuration,
  });

  factory LightSettings.fromJson(Map<String, dynamic> json) {
    return LightSettings(
      color: (json['color'] != null && json['color'] is Map<String, dynamic>) ? ColorRGB.fromJson(json['color'] as  Map<String, dynamic>) : null,
      lightOnDuration: json['light_on_duration']?.toString(),
      lightOffDuration: json['light_off_duration']?.toString(),
    );
  }
  final ColorRGB? color;
  final String? lightOnDuration;
  final String? lightOffDuration;

  Map<String, dynamic> toJson() {
    return {
      'color': color?.toJson(),
      'light_on_duration': lightOnDuration,
      'light_off_duration': lightOffDuration,
    }..removeWhere((k, v) => v == null);
  }
}
