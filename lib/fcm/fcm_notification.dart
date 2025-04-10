// ignore_for_file: public_member_api_docs


class FcmNotification {

  // Android-specific fields
  // final String? titleLocKey;
  // final List<String>? titleLocArgs;
  // final String? bodyLocKey;
  // final List<String>? bodyLocArgs;

  FcmNotification({
    this.title,
    this.body,
    this.image,
    // this.titleLocKey,
    // this.titleLocArgs,
    // this.bodyLocKey,
    // this.bodyLocArgs,
  });

  factory FcmNotification.fromJson(Map<String, dynamic> json) {
    return FcmNotification(
      title: json['title']?.toString(),
      body: json['body']?.toString(),
      image: json['image']?.toString(),
      // titleLocKey: json['title_loc_key']?.toString(),
      // titleLocArgs: (json['title_loc_args'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      // bodyLocKey: json['body_loc_key']?.toString(),
      // bodyLocArgs: (json['body_loc_args'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }
  final String? title;
  final String? body;
  final String? image;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'image': image,
      // 'title_loc_key': titleLocKey,
      // 'title_loc_args': titleLocArgs,
      // 'body_loc_key': bodyLocKey,
      // 'body_loc_args': bodyLocArgs,
    }..removeWhere((k, v) => v == null);
  }
}
