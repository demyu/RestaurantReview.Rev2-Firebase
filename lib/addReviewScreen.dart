import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Restaurant.dart';
import 'Reviewer.dart';
import 'Reviews.dart';
import 'mainScreen.dart';

class AddReviewScreen extends StatefulWidget {
  final MainScreenState mainScreen;
  AddReviewScreen(this.mainScreen);
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  CollectionReference _usersData, _restaurantname;
  List<Reviewer> reviewers;
  List<String> rev, res;
  List<Restaurant> restaurant;
  String resValue, revValue, stars;
  final revi = TextEditingController();

  void getGroups() async {
    rev = List();
    res = List();
    restaurant = List();
    reviewers = List();

    _restaurantname = FirebaseFirestore.instance.collection('restaurant');
    _usersData = FirebaseFirestore.instance.collection('reviewer');

    if (_usersData != null) {
      reviewers = [];
      QuerySnapshot data = await _usersData.get();
      for (QueryDocumentSnapshot item in data.docs) {
        Reviewer currUser =
            Reviewer.withID(item.reference, item.get("reviewername"));
        reviewers.add(currUser);
      }
    }
    for (int i = 0; i < reviewers.length; i++) {
      rev.add(reviewers[i].getUsername());
    }

    if (_restaurantname != null) {
      restaurant = [];
      QuerySnapshot data = await _restaurantname.get();
      for (QueryDocumentSnapshot item in data.docs) {
        Restaurant currUser =
            Restaurant.withID(item.reference, item.get("restaurantname"));
        restaurant.add(currUser);
      }
    }

    for (int i = 0; i < restaurant.length; i++) {
      res.add(restaurant[i].getUsername());
    }

    setState(() {
      res = res;
      rev = rev;
    });
  }

  void addToDb() async {
    String review = revi.text;

    await FirebaseFirestore.instance.runTransaction(
        (transaction) => FirebaseFirestore.instance.collection("reviews").add({
              "reviewername": resValue,
              "restaurantname": revValue,
              "review": review,
              "stars": int.parse(stars),
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (res == null) {
      getGroups();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Review"),
      ),
      body: Column(children: [
        DropdownButton<String>(
            value: revValue,
            items: rev.map((String val) {
              return new DropdownMenuItem<String>(
                value: val,
                child: new Text(val),
              );
            }).toList(),
            onChanged: (newVal) {
              this.setState(() {
                revValue = newVal;
              });
            }),
        DropdownButton<String>(
            value: resValue,
            items: res.map((String val) {
              return new DropdownMenuItem<String>(
                value: val,
                child: new Text(val),
              );
            }).toList(),
            onChanged: (newVal) {
              this.setState(() {
                resValue = newVal;
              });
            }),
        DropdownButton<String>(
          value: stars,
          items: <String>['1', '2', '3', '4', '5'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              stars = value;
            });
          },
        ),
        TextField(
          controller: revi,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter Review here'),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Column(children: [
              RaisedButton(
                onPressed: () {
                  addToDb();
                  widget.mainScreen.refresh();
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
