// ignore_for_file: public_member_api_docs


class FcmData {

  FcmData({this.data});

  factory FcmData.fromJson(Map<String, dynamic> json) {
    return FcmData(data: json);
  }
  final Map<String, dynamic>? data;

  Map<String, dynamic> toJson() {
    return data ?? {};
  }
}
