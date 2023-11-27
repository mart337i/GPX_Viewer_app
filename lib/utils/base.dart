import 'dart:convert';
import 'dart:io';

Future<String> encodeFileToBase64(String filePath) async {
  File file = File(filePath);
  List<int> fileBytes = await file.readAsBytes();
  String base64String = base64Encode(fileBytes);
  return base64String;
}