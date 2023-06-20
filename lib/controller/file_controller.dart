import 'dart:io';
import 'package:path_provider/path_provider.dart';

// 'yyyy-MM-ddTHH:mm:ss 0 0 0 0 0 0,'
class FileController {
  static Future<void> init() async {
    String filepath =
        '${(await getApplicationDocumentsDirectory()).path}/plogger/ploggingModels.txt';

    // await File(filepath).delete();

    if (!await File(filepath).exists()) {
      await File(filepath).create(recursive: true);
    }
  }

  static Future<String> fileReadAsString() async {
    String filepath =
        '${(await getApplicationDocumentsDirectory()).path}/plogger/ploggingModels.txt';
    return await File(filepath).readAsString();
  }

  static Future<void> fileWriteAsString(String fileString) async {
    String filepath =
        '${(await getApplicationDocumentsDirectory()).path}/plogger/ploggingModels.txt';
    await File(filepath).writeAsString(fileString, mode: FileMode.append);
  }
}
