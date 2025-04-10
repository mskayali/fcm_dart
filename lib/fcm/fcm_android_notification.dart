// ignore_for_file: public_member_api_docs

import 'package:google_services/fcm/light_settings.dart';


/// A notification for Android devices.
class FcmAndroidNotification {

  FcmAndroidNotification({
    this.title,
    this.body,
    this.icon,
    this.color,
    this.sound,
    this.tag,
    this.clickAction,
    this.bodyLocKey,
    this.bodyLocArgs,
    this.titleLocKey,
    this.titleLocArgs,
    this.channelId,
    this.ticker,
    this.sticky,
    this.eventTime,
    this.localOnly,
    this.defaultSound,
    this.defaultVibrateTimings,
    this.defaultLightSettings,
    this.vibrateTimings,
    this.visibility,
    this.notificationPriority,
    // this.timeoutAfter,
    this.image,
    this.lightSettings,
  });

  factory FcmAndroidNotification.fromJson(Map<String, dynamic> json) {
    return FcmAndroidNotification(
      title: json['title']?.toString(),
      body: json['body']?.toString(),
      icon: json['icon']?.toString(),
      color: json['color']?.toString(),
      sound: json['sound']?.toString(),
      tag: json['tag']?.toString(),
      clickAction: json['click_action']?.toString(),
      bodyLocKey: json['body_loc_key']?.toString(),
      bodyLocArgs: (json['body_loc_args'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      titleLocKey: json['title_loc_key']?.toString(),
      titleLocArgs: (json['title_loc_args'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      channelId: json['channel_id']?.toString(),
      ticker: json['ticker']?.toString(),
      sticky: bool.tryParse(json['sticky'].toString()) ,
      eventTime: json['event_time'] != null ? DateTime.tryParse(json['event_time'].toString()) : null,
      localOnly: bool.tryParse(json['local_only'].toString()) ,
      defaultSound: bool.tryParse(json['default_sound'].toString()),
      defaultVibrateTimings: bool.tryParse(json['default_vibrate_timings'].toString()),
      defaultLightSettings: bool.tryParse(json['default_light_settings'].toString()),
      vibrateTimings: (json['vibrate_timings'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      visibility: json['visibility']?.toString(),
      notificationPriority: json['notification_priority']?.toString(),
      // timeoutAfter: json['timeout_after']?.toString(),
      image: json['image']?.toString(),
      lightSettings: (json['light_settings'] != null && json['light_settings'] is Map<String,dynamic>)  ? LightSettings.fromJson(json['light_settings'] as  Map<String, dynamic>) : null,
    );
  }
  final String? title;
  final String? body;
  final String? icon;
  final String? color;
  final String? sound;
  final String? tag;
  final String? clickAction;
  final String? bodyLocKey;
  final List<String>? bodyLocArgs;
  final String? titleLocKey;
  final List<String>? titleLocArgs;
  final String? channelId;
  final String? ticker;
  final bool? sticky;
  final DateTime? eventTime;
  final bool? localOnly;
  final bool? defaultSound;
  final bool? defaultVibrateTimings;
  final bool? defaultLightSettings;
  final List<String>? vibrateTimings;
  final String? visibility;
  final String? notificationPriority;
  // final String? timeoutAfter;
  final String? image;
  final LightSettings? lightSettings;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'icon': icon,
      'color': color,
      'sound': sound,
      'tag': tag,
      'click_action': clickAction,
      'body_loc_key': bodyLocKey,
      'body_loc_args': bodyLocArgs,
      'title_loc_key': titleLocKey,
      'title_loc_args': titleLocArgs,
      'channel_id': channelId,
      'ticker': ticker,
      'sticky': sticky,
      'event_time': eventTime?.toIso8601String(),
      'local_only': localOnly,
      'default_sound': defaultSound,
      'default_vibrate_timings': defaultVibrateTimings,
      'default_light_settings': defaultLightSettings,
      'vibrate_timings': vibrateTimings,
      'visibility': visibility,
      'notification_priority': notificationPriority,
      // 'timeout_after': timeoutAfter,
      'image': image,
      'light_settings': lightSettings?.toJson(),
    }..removeWhere((k, v) => v == null);
  }
}
