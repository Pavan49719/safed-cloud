import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class TendersList extends StatefulWidget {
  const TendersList({Key? key}) : super(key: key);

  @override
  State<TendersList> createState() => _TendersListState();
}

class _TendersListState extends State<TendersList> {
  List<DocumentSnapshot>? documents;
  int? Count;

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
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: const Text('More Information'),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: documents?[index]
                                                      ['requested-by']
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                    leading:
                                                        Text("${index + 1}"),
                                                    trailing: const Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 15),
                                                    ),
                                                    title: Text(
                                                        "${documents?[index]['requested-by'][index]}"),
                                                        );
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.list,
                              color: Colors.blue,
                            ),
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
