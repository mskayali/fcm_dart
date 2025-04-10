// ignore_for_file: public_member_api_docs


class FcmOptions {

  FcmOptions({this.analyticsLabel, this.link});

  factory FcmOptions.fromJson(Map<String, dynamic> json) {
    return FcmOptions(
      analyticsLabel: json['analytics_label']?.toString(),
      link: json['link']?.toString(),
    );
  }
  final String? analyticsLabel;
  final String? link;

  Map<String, dynamic> toJson() {
    return {
      'analytics_label': analyticsLabel,
      'link': link,
    }..removeWhere((k, v) => v == null);
  }
}
