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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Milk Price'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pickedFile != null
                ? Text("Selected File: ${pickedFile!.name}")
                : Container(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Select file'),
              onPressed: selectFile,
            ),
            pickedFile != null
                ? ElevatedButton(
                    child: Text('Upload file'),
                    onPressed: uploadFile,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
