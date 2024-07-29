// ignore_for_file: constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String FIREBASE_MESSAGING_NOTIFICATION_URL =
      'https://fcm.googleapis.com/v1/projects/chatico-c302e/messages:send';
  static const String SHOW_NOTIFICATION = 'show-notification';
  static Map<String, String> serviceAccount = {
    "type": dotenv.env['TYPE']!,
    "project_id": dotenv.env['PROJECT_ID']!,
    "private_key_id": dotenv.env['PRIVATE_KEY_ID']!,
    "private_key": dotenv.env['PRIVATE_KEY']!,
    "client_email": dotenv.env['CLIENT_EMAIL']!,
    "client_id": dotenv.env['CLIENT_ID']!,
    "auth_uri": dotenv.env['AUTH_URI']!,
    "token_uri": dotenv.env['TOKEN_URI']!,
    "auth_provider_x509_cert_url": dotenv.env['AUTH_PROVIER_X509_CERT_URL']!,
    "client_x509_cert_url": dotenv.env['CLIENT_X509_CERT_URL']!,
    "universe_domain": dotenv.env['UNIVERSE_DOMAIN']!,
  };
  static const List<String> scopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/firebase.database',
    'https://www.googleapis.com/auth/firebase.messaging',
  ];
}
