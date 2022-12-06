import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<DocumentSnapshot>? documents;
  int? Count;

  readData() async {
    final _firestore = FirebaseFirestore.instance;
    final QuerySnapshot result =
        await _firestore.collection('pickup-request').get();
    setState(() {
      documents = result.docs;
      Count = documents?.length;
    });
  }

  Future accepted(String email) async {
    final docUser =
        FirebaseFirestore.instance.collection('pickup-request').doc(email);
    final json = {'status': 'Accepted'};
    await docUser.update(json);
  }

  Future rejected(String email) async {
    final docUser =
        FirebaseFirestore.instance.collection('pickup-request').doc(email);
    final json = {'status': 'Rejected'};
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
        title: Text('Milk orders'),
        actions: [
          IconButton(
              onPressed: () async {
                await readData();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: ListView.builder(
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
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      documents?[index]['status'] == 'Pending'
                          ? Icon(Icons.pending_actions,color: Colors.yellow[800],)
                          : documents?[index]['status'] == 'Accepted'
                              ? Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
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
                                        'Name: ${documents?[index]['name']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Location: ${documents?[index]['location']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Email: ${documents?[index]['email']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Mode: ${documents?[index]['mode']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Shift:${documents?[index]['shift']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Status:${documents?[index]['status']}'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            await rejected(
                                                documents?[index]['email']);
                                          },
                                          child: Text('Reject')),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await accepted(
                                                documents?[index]['email']);
                                          },
                                          child: Text('Accept'))
                                    ],
                                  )
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
          }),
    );
  }
}
