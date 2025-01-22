import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConst {
  AppConst._();
  static String spreadSheetId = dotenv.env['SPREADSHEET_ID']!;
  // static final String credentials = dotenv.env['CREDENTIALS_JSON']!;
  static final String credentials = jsonEncode(
    jsonDecode(dotenv.env['GOOGLE_CREDENTIALS']!)
      ..['private_key'] =
          (jsonDecode(dotenv.env['GOOGLE_CREDENTIALS']!)['private_key']
                  as String)
              .replaceAll('\\n', '\n'),
  );
  static String qrSheetTitle = dotenv.env['QR_SHEET_TITLE']!;
}
