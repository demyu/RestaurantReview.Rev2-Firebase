import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Reviewer.dart';

class ReviewerScreen extends StatefulWidget {
  _ReviewerScreenState createState() => _ReviewerScreenState();
}

class _ReviewerScreenState extends State<ReviewerScreen> {
  CollectionReference _usersData;
  final name = TextEditingController();

  void addReviewer() async{
    String a = name.text;
    Reviewer rev = Reviewer(a);

    await FirebaseFirestore.instance.runTransaction(
        (transaction) => FirebaseFirestore.instance.collection("reviewer").add({
              "reviewername": a,
            }));
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Reviewer"),
      ),
      body: Column(children: [
        TextField(
          controller: name,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter reviewer name'),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Column(children: [
              RaisedButton(
                onPressed: () {
                  addReviewer();
                  Navigator.pop(context);
                },
                child: const Text('Save', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
              ),
            ]))
      ]),
    );
  }
}
