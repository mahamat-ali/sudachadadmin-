import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sudachadadmin/theme/btn_style.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key, this.uid}) : super(key: key);
  final uid;
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  CollectionReference rencontres =
      FirebaseFirestore.instance.collection('rencontres');

  Future<void> updateRencontre(value, docId) {
    return rencontres
        .doc(docId)
        .update({'accepted': value, 'isNew': false})
        .then((value) => print("doc Updated"))
        .catchError((error) => print("Failed to update document: $error"));
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _rencontresStream = FirebaseFirestore.instance
        .collection('rencontres')
        .where('to', isEqualTo: widget.uid)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _rencontresStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.purpleAccent,
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return Container(
              padding: EdgeInsets.all(6),
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10,
                    bottom: 6,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          data['raisonDeRencontre'],
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'A l\'honeur de:',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${data['nom']} ${data['prenom']}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Numero:',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data['numeroMobile'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await updateRencontre('accept', document.id);
                                },
                                child: Text('Accepter'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await updateRencontre('reject', document.id);
                                },
                                child: Text(
                                  'Refuser',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
