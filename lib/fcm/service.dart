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
      'spinex-turp':{
        'success':'https://api.spinex.io/callbacks',
        'fail':'https://api.spinex.io/callbacks',
      },
      'remote-patient':{
        'success':'https://api.map2heal.com/callbacks',
        'fail':'https://api.map2heal.com/callbacks',
      },
    };
final serviceAccounts = {
      'spinex-turp':<String,dynamic>{
        'type': 'service_account',
        'project_id': 'spinex-turp',
        'private_key_id': '83193cad109ba204d1ef9bdd4767df45e81a6b72',
        'private_key':
            '-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCWkqHafWL7+HmF\nHvk1tFW4UXgz/QI0H3tdV8CaKF2alVc66X10bMT885uJPQOQHffwj43S5Sg6uJZt\nQyE/W20TuvrhzJ8QBo8YSRgWrACQZKpS3RXF//GIinHQJFVhRPHS1thhL4uFwGJ2\nvvH0VezZzsAN0CvjGf1dydvwVRG/WtlBJAJF3fopCzz29pzi6BiUyx1IA2HjDUhI\nXHBo6zW5cwqB/pk6M74TPmZgcOGAs/HmJU+bFhi/1SjkOz9PyNNPBELotYycHxwG\nOeDEYaa8Og7Hk4Cw3GIeHUA08+OU49fxJdOCT9GYoR8VRKl7bMICq72aKyWSWSSm\n1L39myLfAgMBAAECggEADma45JkAf3as8hQGeYyldDW/6EJcfxgRva7tGhwek8Xm\ngW51Ps5BFavGZl0NEFrQF382F9kuEgEMoNJTsD0c1M8Z5sB3ktn7FAi4V+wcjl2V\nGCF9ecy4e7rjbCkazMJXhLcNcVd8TI8cJnJYhD+MTJVkiLhZMjqOoUqeEWxO1b0u\nRbRC5IZruWfZ3oIg5hd6dTibKwOiXXMqe5IBbicO/5+Sz+s4LhxqikPdx46DBEki\nj9grbP/OC/1mUMua3IXSyMMq6uBOMmQ/uIDYTMuT5q5A93h6GPqFvRCYMy3Z8C6X\nDWunFBHZdgdAzuxjDrDPnavOFhNmLvlEfmFNi2PVMQKBgQDMarFD2moeQQcnvG93\nFVQDNGlA2dsEmONgikea3La/U23g3f/aJvKcqwAGvgx1jxqVzjaQ+6ufR11clhdM\njiPlEzg6Ga/5vDujtIkshMGqGf9L7PldfLWfemYYFKFJ+0+Cb0c5gYda0ZZvs6jP\neoQs0k1Cukn8L86r93IE8s3oTwKBgQC8kZ9aKALEH5PTg5DbqsemgTIUzomeh7zL\nL066Bx4Dl9D9lHlgB+WH6xGky5+OjShGxLPD/IgMa0rCEQgPlczm1Lxpfeie/xK2\nQ9lj2oHFF7XBZtU9J0LWLbKgTCEw3G96kgHQSSEpxrhJo2/dxXnpKMvV6+MxcVIV\npVAdqtDocQKBgFEyUBdTurMpwV3XS69RmX1sZCKOZqD82dSPGMI6yZxV119qzyYo\nMlZo1inXc7t+jGDU+He+f/1Uq5ELTVXrX/auG7d4XJ4mVso/+/zi/spCaVYPWz33\nO22NgOAv0aFBYeO9r9z3xnwcpFTaWEORts7W+jl3Jcw2cTF9qJyulXuhAoGBAJzc\ncne38t0c+4am2jixbxWGQZfnW7mhZp6LAu1jAEey4aof+Xu19e1D0VCKBne52rhL\n5tJw3ued1Pls24zDa0jVzMngcELbIsC13j/fQ7YljA+PMHGHmGS8bOxFiBKyPJX0\noUeXndu3sBOpvmP4Yvpe8nlImZzGjKbu9p9HOjMxAoGAAOmrwKQrshCwPY1cO/4E\nBqjrwtkvnIsr9mkCcebM5mquPG9iUpKs3DpTyKJsh5qZ8fCRpL588sBKvQHmESGw\njqKQP355QPjC0T6JlzRwOjZhYeejTTI/85cjaM0OsJj2+lGLYdR3llYakyj9FfDG\nqFm6sEx9lPl5mjhEjCGeuz0=\n-----END PRIVATE KEY-----\n',
        'client_email': 'firebase-adminsdk-d1yae@spinex-turp.iam.gserviceaccount.com',
        'client_id': '107413720130120232691',
        'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
        'token_uri': 'https://oauth2.googleapis.com/token',
        'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
        'client_x509_cert_url': 'https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-d1yae%40spinex-turp.iam.gserviceaccount.com',
        'universe_domain': 'googleapis.com',
      },
      'remote-patient':{
        'type': 'service_account',
        'project_id': 'remote-patient',
        'private_key_id': 'abb4f05574a33221186615069593c4fb45eb65a7',
        'private_key':
            '-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDcCgw67dto5gvt\nJzhQvlD2H2D6N7NFCEPmdShOpMZ9qtCKhHkz6wEXIHJuMedHteuFDx3g7tAjrimH\nR+66X2Wm79eVZorZu9AI6CSwCs/iuVs52t4KrulCYRRMgAKsX7q32+8KAtNk6Tbe\n68kis0aDQ+lnWPHQisD5+dp2fyel0T+kv/MISByL0RAvFUk4pZVUgLwjrv+dikS5\nQ3/Z/4qA0AUOIRbOIy36UOYh6Im5PYPgROokpH2lSFG8pRRnE8b7TyvdAFePP/M0\nx743ZQqnkiDxhr5bUDoK0c4CwzYApyHcST0X9FqwbJo2THelmHsyqJCKPF3PGtHD\nVK85c82HAgMBAAECggEAJ8lBUN51T9BY07bFvgPLi9U8qcGsjoziCieg9CdjJJHg\nR0uQxsx1VAMv7bDkStkgDt0e3+8Of4UcSTO+fMCHFtpDNuZlsNz+zr169MHfuPUf\nA6UJhRD/aFs5WmPDF/vvPRNtc3fzVUm9/CzSH44e79k1uNQiVTzhi9GbqNVxC9Am\nOkQ32Na5VqZpzc17azL6/TgYfOOsxLfJNm1kh3kkXJtBd/duJVn+fg4u6/VM8OE5\nup4W+YA2r3Eyf8PBL+gNrEx4ERl/r+OHbItrfAVPTkteTQdMO/UH1z4qn+Zvd2SC\nrkb4bj4GC3ZmTTbo6DWKMaWpB6pDLYSWTvnANJL6kQKBgQD1sJYuXYphntsST1y/\noeFs864kDTqzQfbxl65Q7uDVJ7tdUQ+xc2LRbIPM9DRgzD20dZ31/+bKmS5PYvy0\n5ESUz9RLH8HsVfRvTRJsGeU9GpxXO3i4gGp3EkwXHM50U+yo2dx62/MtTrFzrdcL\ndC4+hXH+ZTYXpIMqNbBGf7GlZQKBgQDlReaUS7eXSygwKXJuAiBbW51IhdZ4repj\nSTC0+GQ7S1llQpnBBbeuK57utAdbTQtVUVZAlcmTxeSmbb5NMtmeLdpxfb1BwjDf\nHOu3qcY+lomV2r74bxHAHP0Y+eULABMhoN8cmMJ6YyW0FjGg7J7EiUSvUuHVJGs9\n4QesNSGeewKBgFYEkj//bfCJrod1k7JgGc2Mbz6eBxw1jyC8i0I4sCzQsU+VjtoA\n3OsXg/mg0inFuCDTQQ+cnY/3G3id3n3yoXQ8Y0Y+AyYcXe0N3dJNKq4+/9emsbhe\n9Wdk15EL+9hMfcIMLJ4zHauSLpyik3SmI36uN9/qTYrvhSClFWdJU8flAoGANKhV\nSQIK7IiqdkVOrs12OQVVnm5+z8DB8IPC2A2kl6m6onMldRunEC2clx5qAiIz1CiW\nMsc0QOhWl5Lk/j4LlTTa0u4aJZxANT4jNU+c5IsWloBjFBQOc5001COw41HlEvgr\nxhmfsRRMeIwQYfF2lZUhXVMf4yA2MUQZywd47TkCgYA8twsQr+pQ+CxKkFbbwC9S\nsarXkCWO+MH4lke/Gth+Q9OhyIl83NQIdTPSht2tfY7PmeH2gMSxZ/EqabL9Ivn7\nr/bHPE4nQ6wtSjq4jmUHvCSrtn/sSdhGWSx0Ezz0jzvY/FZhfb1IXB8cE2X15Oza\nkawTCh5Rd6oUkkFPAp0Tmg==\n-----END PRIVATE KEY-----\n',
        'client_email': 'firebase-adminsdk-x5ga9@remote-patient.iam.gserviceaccount.com',
        'client_id': '102258269340996148768',
        'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
        'token_uri': 'https://oauth2.googleapis.com/token',
        'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
        'client_x509_cert_url': 'https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-x5ga9%40remote-patient.iam.gserviceaccount.com',
        'universe_domain': 'googleapis.com',
      },
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
