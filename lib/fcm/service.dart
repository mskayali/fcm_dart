// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs

import 'dart:convert';

import 'package:google_services/fcm/fcm_message.dart';
import 'package:google_services/utils/models.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:queue/queue.dart' as que;




/// Singleton class for Firebase authentication
class FirebaseService {
  factory FirebaseService() => _instance;
  FirebaseService._internal();
  static final FirebaseService _instance = FirebaseService._internal();

  final List<String> _scopes = [
    'https://www.googleapis.com/auth/firebase.messaging',
    // 'https://www.googleapis.com/auth/cloud-platform',
  ];

  final Map<String,auth.AuthClient> _authClient={};
  final Map<String,String> _accessToken={};
  final Map<String,DateTime> _tokenExpiry={};
  String? _projectId;
  final Map<String,que.Queue> queues ={};

final serviceCallbackUrls={
  '{project-ID}':{
    'success':'{Your Success Webhook Domain}',
    'fail':'{Your Fail Webhook Domain}',
  },
};
/// [serviceAccounts] Give a secret key and value for FCM SECRET Json
/// example: {'uuid':<String,dynamic>{...},}
final Map<String, Map<String, dynamic>> serviceAccounts = {
  // '{project-ID}':<String,dynamic>{FCM SECRET Json},
};

  /// Loads service account credentials
  Future<void> initialize(String serviceId) async {
    
    if(serviceAccounts[serviceId] != null){
      if(queues[serviceId] == null){
        queues[serviceId]=que.Queue();
      }
      final serviceAccountJson=serviceAccounts[serviceId];
      final credentials = auth.ServiceAccountCredentials.fromJson(serviceAccountJson);
      _projectId = serviceAccountJson!['project_id'].toString();

      final client = http.Client();
      _authClient[serviceId] = await auth.clientViaServiceAccount(credentials, _scopes);
      _updateToken(_authClient[serviceId]!.credentials.accessToken, serviceId);
      client.close();
    }else{
      throw Exception('Service File is not Exist');
    }
  }

  /// Updates the stored token and expiry time
  void _updateToken(auth.AccessToken token, String serviceId) {
    _accessToken[serviceId] = token.data;
    _tokenExpiry[serviceId] = token.expiry;
  }

  /// Checks if the auth token is still valid; refreshes if needed
  Future<void> _ensureValidAuth(String serviceId) async {
    if (_authClient[serviceId] == null || _accessToken[serviceId] == null || _tokenExpiry[serviceId] == null || DateTime.now().isAfter(_tokenExpiry[serviceId]!)) {
      await initialize(serviceId);
    }
  }

  /// Sends a notification to a device token
  Future<http.Response> sendNotification(
    String serviceId,
    FcmMessage message,
  ) async {
    
    await _ensureValidAuth(serviceId);
    if(!queues.containsKey(serviceId)){
      throw Exception('Invalid serviceId');
    }
    return queues[serviceId]!.add<http.Response>(() async {
       // Ensure we have a valid token before proceeding
      final url = Uri.parse('https://fcm.googleapis.com/v1/projects/$_projectId/messages:send');
      final notificationData = {
        'message': message.toJson(),
      };
      // print(jsonEncode(notificationData) );
      return _authClient[serviceId]!.post(
        url,
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(notificationData),
      ).then((vla){
        // ignore: avoid_print
        print(vla.body);
        return vla;
      // ignore: invalid_return_type_for_catch_error
      }).catchError(print);
    })
    .timeout(const Duration(seconds: 3))
    .onError((e,s){
      final client = http.Client();
      if(serviceCallbackUrls.containsKey(serviceId)){
        final url = Uri.tryParse(serviceCallbackUrls[serviceId]!['fail'].toString());
        if (url != null) {
          client.post(
            url,
            body: {'error': e.toString()},
            headers: {
              'Content-Type': 'application/json',
            },
          ).timeout(const Duration(seconds: 3));
        }
      }
      final res=DefaultResponse(
        message: 'fail',
        data: e.toString(),
        statusCode:422,
      );
      return http.Response(
        jsonEncode(res.toMap()),
        res.statusCode,
      );
    }).then((onValue){
          if (serviceCallbackUrls.containsKey(serviceId)) {
            final client = http.Client();
            final url = Uri.tryParse(serviceCallbackUrls[serviceId]!['success'].toString());
            if (url != null) {
              client.post(
                url,
                body: onValue.body,
                headers: onValue.headers,
              ).timeout(const Duration(seconds: 3));
            }
          }
          final res = DefaultResponse(
            message: onValue.statusCode == 200 ? 'success' : 'info',
            data: onValue.body,
            statusCode: onValue.statusCode,
          );
          return http.Response(
            jsonEncode(res.toMap()),
            res.statusCode,
          );
    });
  }
}
