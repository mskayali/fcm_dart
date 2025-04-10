// ignore_for_file: public_member_api_docs

class ApsAlert {

  ApsAlert({
    this.title,
    this.body,
    this.titleLocKey,
    this.titleLocArgs,
    this.subtitle,
    this.subtitleLocKey,
    this.subtitleLocArgs,
    this.bodyLocKey,
    this.bodyLocArgs,
    this.launchImage,
  });

  factory ApsAlert.fromJson(Map<String, dynamic> json) {
    return ApsAlert(
      title: json['title']?.toString(),
      body: json['body']?.toString(),
      titleLocKey: json['title-loc-key']?.toString(),
      titleLocArgs: (json['title-loc-args'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      subtitle: json['subtitle']?.toString(),
      subtitleLocKey: json['subtitle-loc-key']?.toString(),
      subtitleLocArgs: (json['subtitle-loc-args'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      bodyLocKey: json['body-loc-key']?.toString(),
      bodyLocArgs: (json['body-loc-args'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      launchImage: json['launch-image']?.toString(),
    );
  }
  final String? title;
  final String? body;
  final String? titleLocKey;
  final List<String>? titleLocArgs;
  final String? subtitle;
  final String? subtitleLocKey;
  final List<String>? subtitleLocArgs;
  final String? bodyLocKey;
  final List<String>? bodyLocArgs;
  final String? launchImage;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'title-loc-key': titleLocKey,
      'title-loc-args': titleLocArgs,
      'subtitle': subtitle,
      'subtitle-loc-key': subtitleLocKey,
      'subtitle-loc-args': subtitleLocArgs,
      'body-loc-key': bodyLocKey,
      'body-loc-args': bodyLocArgs,
      'launch-image': launchImage,
    }..removeWhere((k, v) => v == null);
  }
}
