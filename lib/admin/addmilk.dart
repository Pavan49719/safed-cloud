import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunchUrl(Uri.parse((scanData.code)!))) {
        await launchUrl(Uri.parse((scanData.code)!));
        controller.resumeCamera();
      } else {
        showDialog(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddMilk(scanData.code!)));
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ],
    );
  }
}

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}


class AddMilk extends StatefulWidget {
  String email;
  AddMilk(this.email);

  @override
  State<AddMilk> createState() => _AddMilkState();
}

class _AddMilkState extends State<AddMilk> {
  var _sValue;
  var _milktype;



  String? sdate;
  TextEditingController dateController = TextEditingController();

  TextEditingController fat = TextEditingController();
  TextEditingController snf = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController total = TextEditingController();

  int quant=0;
  int ra=0;

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Milk"),
          actions: [
            IconButton(
                icon: Icon(Icons.history),
                onPressed: () {

                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(15),
                  height: 150,
                  child: Center(
                      child: TextField(
                        controller:
                        dateController, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date" //label text of field
                        ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              dateController.text = formattedDate;
                              sdate =
                                  formattedDate; //set foratted date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ))),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Id',style: TextStyle(fontSize: 20),),
                  SizedBox(width: 20,),
                  SizedBox(width: 20,),
                  Container(
                      child:  Text(widget.email,style: TextStyle(fontSize: 20),)
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      'Shift:',
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
                        const Text('Morning',
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
                        const Text('Evening',
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
              SizedBox(
                height: 20,
              ),
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
                          groupValue: _milktype,
                          onChanged: (value) {
                            setState(() {
                              _milktype = value;
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
                          groupValue: _milktype,
                          onChanged: (value) {
                            setState(() {
                              _milktype = value;
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
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    height: 50,
                    child: TextField(
                      controller: fat,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF20BCDE),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.only(top: 5, left: 35),
                        hintText: 'Enter FAT',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    height: 50,
                    child: TextField(
                      controller: snf,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF20BCDE),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.only(top: 5, left: 35),
                        hintText: 'Enter SNF',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    height: 50,
                    child: TextField(
                      controller: quantity,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF20BCDE),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.only(top: 5, left: 35),
                        hintText: 'Enter Quantity',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    height: 50,
                    child: TextField(
                      controller: rate,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF20BCDE),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.only(top: 5, left: 35),
                        hintText: 'Enter Rate',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Quantity',style: TextStyle(fontSize: 20),),
                      SizedBox(width: 20,),
                      SizedBox(width: 20,),
                      Container(
                        child:  Text(ra.toString(),style: TextStyle(fontSize: 20),)
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ra=int.parse(rate.text)*int.parse(quantity.text);
                      });
                    },
                    child: Center(
                      child: Container(
                        width: 120,
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
                    width: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xFF20BCDE),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
