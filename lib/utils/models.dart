import 'package:dart_frog/dart_frog.dart';

class DefaultResponse {
  DefaultResponse({required this.message, this.data, this.statusCode = 200, this.headers = const {}});
  int statusCode;
  String message;
  dynamic data;
  Map<String, Object> headers;

  static Map<String, dynamic> filterEmptyEntries(Map<String, dynamic> input) {
    final filtered = <String, dynamic>{};
    input.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        // Recursively filter nested maps
        final nestedFiltered = filterEmptyEntries(value);
        if (nestedFiltered.isNotEmpty) {
          filtered[key] = nestedFiltered;
        }
      } else if (value is List) {
        // Filter lists recursively
        final filteredList = value
            .map((item) => item is Map<String, dynamic> ? filterEmptyEntries(item) : item)
            .where((item) => item != null && item.toString().trim().isNotEmpty)
            .toList();
        if (filteredList.isNotEmpty) {
          filtered[key] = filteredList;
        }
      } else if (value != null && value.toString().trim().isNotEmpty) {
        // Add non-empty primitive values
        filtered[key] = value;
      }
    });
    return filtered;
  }

  Map<String,dynamic> toMap(){
    return filterEmptyEntries({
      'success': statusCode == 200,
      'message': message,
      'data': data,
    });
  }

  Response json() {
    return Response.json(
      statusCode: statusCode,
      body: filterEmptyEntries({
        'success': statusCode == 200,
        'message': message,
        'data': data,
      }),
    );
  }
}
