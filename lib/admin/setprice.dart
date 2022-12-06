import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SetMilkPrice extends StatefulWidget {
  const SetMilkPrice({Key? key}) : super(key: key);

  @override
  State<SetMilkPrice> createState() => _SetMilkPriceState();
}

class _SetMilkPriceState extends State<SetMilkPrice> {
  PlatformFile? pickedFile;

  selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Milk Price'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Select file'),
              onPressed: selectFile,
            ),
            ElevatedButton(
              child: Text('Upload file'),
              onPressed: uploadFile,
            ),
          ],
        ),
      ),
    );
  }
}
