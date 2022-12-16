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
  var _sValue;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'Milk Type:',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                // margin: const EdgeInsets.only(
                //     top: 5, left: 5, right: 5, bottom: 5),
                // height: 75,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cow',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                    Radio(
                      toggleable: true,
                      value: 1,
                      groupValue: _sValue,
                      onChanged: (value) {
                        setState(() {
                          _sValue = value;
                        });
                      },
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFF20BCDE)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                // margin: const EdgeInsets.only(
                //     top: 5, left: 55, right: 5, bottom: 5),
                // height: 75,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Buffalo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                    Radio(
                      toggleable: true,
                      value: 2,
                      groupValue: _sValue,
                      onChanged: (value) {
                        setState(() {
                          _sValue = value;
                        });
                      },
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFF20BCDE)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
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
        ],
      ),
    );
  }
}
