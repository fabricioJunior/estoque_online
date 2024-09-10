import 'dart:io';

import 'package:path_provider/path_provider.dart' as path;

Future<Directory> dataBaseDirectory() async {
  final dir = await path.getApplicationDocumentsDirectory();
  return Directory('${dir.path}/mentor.hive');
}
