import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnv() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'API KEY NOT FOUND';
}
