import 'package:dart_frog/dart_frog.dart';
import 'package:google_services/utils/models.dart';

Response onRequest(RequestContext context) {
  return DefaultResponse(message: 'Status: Healty!', data: true).json();
}
