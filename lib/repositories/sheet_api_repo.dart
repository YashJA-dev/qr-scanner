import 'package:gsheets/gsheets.dart';
import 'package:qrscanner/configs/app_const.dart';
import 'package:qrscanner/repositories/base_api_repo.dart';

class SheetApiRepo extends BaseApiRepo {
  final GSheets _gSheets;
  Worksheet? _worksheet;
  SheetApiRepo({required GSheets gSheets}) : _gSheets = gSheets {
    _initialize();
  }
  Future<void> _initialize() async {
    final spreadSheet = await _gSheets.spreadsheet(AppConst.spreadSheetId);
    _worksheet = await spreadSheet.worksheetByTitle(AppConst.qrSheetTitle);
  }

  Future<bool> insert(Map<String, dynamic> data) async {
    try {
      if (_worksheet == null) {
        return false;
      }
      return await _worksheet!.values.map.appendRow(data);
    } on Exception catch (e) {
      return false;
    }
  }
}
