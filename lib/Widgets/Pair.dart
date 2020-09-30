import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:restomanagerfirebase/Restaurant.dart';
import 'package:restomanagerfirebase/ReviewScreen.dart';
import 'package:restomanagerfirebase/Reviewer.dart';
import 'dart:async';
import 'package:restomanagerfirebase/Reviews.dart';

class Pair extends StatefulWidget {
  PairState createState() => PairState();

}

class PairState extends State<Pair> {
  List<Reviews> reviews;
  List<String> stringer;

  void load() async {
    CollectionReference _reviewsData;
    reviews = List();
    stringer = List();

     _reviewsData = FirebaseFirestore.instance.collection('reviews');
    if (_reviewsData != null) {
      QuerySnapshot data = await _reviewsData.get();
      for (QueryDocumentSnapshot item in data.docs) {
        Reviews currUser = Reviews.withID(item.reference, item.get("reviewername"),
            item.get("restaurantname"), item.get("review"), item.get("stars"));
        reviews.add(currUser);
      }
    }

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    if (reviews == null) {
      load();
      setState(() {});
    }
    return Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (BuildContext contect, int index) {
              final review = reviews[index];
              return GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.red[300],
                    child: Center(
                      child: Text(reviews[index].getReviewer() +
                          "---" +
                          reviews[index].getRestaurant()),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ReviewScreen(
                                  review: review,
                                )));
                  });
            }));
  }
}
