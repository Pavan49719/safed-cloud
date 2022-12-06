import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';

class FarmerMilkRate extends StatefulWidget {
  const FarmerMilkRate({Key? key}) : super(key: key);

  @override
  State<FarmerMilkRate> createState() => _FarmerMilkRateState();
}

class _FarmerMilkRateState extends State<FarmerMilkRate> {
  var _value;
  String? urlfile;
  printUrl() async {
    final ref =
        FirebaseStorage.instance.ref().child("files/Invitationletter.pdf");
    String url = (await ref.getDownloadURL()).toString();
    setState(() {
      urlfile = url;
    });
    print("URL: $url");
  }

  String dropdownvalue = 'Katraj Dairy';
  var items = ['Katraj Dairy', 'AMUL Dairy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Select Center',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Rate Chart',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin:
                const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 5),
            height: 75,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cow SNF',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                Radio(
                  toggleable: true,
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFF20BCDE)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin:
                const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 5),
            height: 75,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Buffalo SNF',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                Radio(
                  toggleable: true,
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFF20BCDE)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              printUrl();
            },
            child: Center(
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFF20BCDE),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Get Rate',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          urlfile != null
              ? GestureDetector(
                  onTap: () async {
                    
                  },
                  
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFF20BCDE),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Open file',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
