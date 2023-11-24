import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';


class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async{
                  final result = await FilePicker.platform.pickFiles(type: FileType.any, allowMultiple: false);
                  if (result != null && result.files.isNotEmpty) {
                    final fileBytes = result.files.first.bytes;
                    final fileName = result.files.first.name;
                  
                  }
                  // DO find out how to descruct the file
                } , 
              child: const Text(
                "Upload file"
              )
            ),
          ],
        ),
      ),
    );
  }
}