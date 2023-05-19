import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CTendersList extends StatefulWidget {
  const CTendersList({Key? key}) : super(key: key);

  @override
  State<CTendersList> createState() => _CTendersListState();
}

class _CTendersListState extends State<CTendersList> {
  List<DocumentSnapshot>? documents;
  int? Count;
  final User? user = FirebaseAuth.instance.currentUser;

  readData() async {
    final _firestore = FirebaseFirestore.instance;
    final QuerySnapshot result = await _firestore.collection('tenders').get();
    setState(() {
      documents = result.docs;
      Count = documents?.length;
    });
    print("DATA IS: ${documents?.length}");
    print("DATA IS: ${documents![1]['date']}");
  }

  applyToTender(String key) async {
    final docUser =
        FirebaseFirestore.instance.collection('tenders').doc(key);
    final json = {
      'requested-by': FieldValue.arrayUnion([user?.email])
    };
    await docUser.update(json);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All tenders'),
      ),
      body: Count != null
          ? ListView.builder(
              itemCount: Count,
              itemBuilder: (BuildContext context, int index) {
                // String dtime =
                // timeAgoSinceDate('');
                return Card(
                  child: GFListTile(
                      color: Colors.transparent,
                      avatar: const GFAvatar(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        '${documents?[index]['name']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subTitle: Padding(
                        padding: const EdgeInsets.only(top: 2.50),
                        child: Text(
                          'Location: ${documents?[index]['location']}',
                        ),
                      ),
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.announcement,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: const Text('More Information'),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Importer\'s Name: ${documents?[index]['name']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Importer\'s mail:${documents?[index]['importer-mail']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Location: ${documents?[index]['location']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'date: ${documents?[index]['date']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'fat: ${documents?[index]['fat']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'snf:${documents?[index]['snf']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'quantity:${documents?[index]['quantity']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'price:${documents?[index]['price']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'quantity:${documents?[index]['quantity']}'),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            applyToTender(documents?[index].reference.id??'');
                                            Navigator.pop(context);
                                          },
                                          child: Text("Apply"))
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          // Text(dtime),
                        ],
                      )),
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
