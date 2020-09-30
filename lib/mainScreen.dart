import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ReviewScreen.dart';
import 'Reviews.dart';
import 'addRestaurantScreen.dart';
import 'addReviewScreen.dart';
import 'addReviewerScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  CollectionReference _usersData;
  List<Reviews> reviews;
  List<String> stringer;

  void load() async {
    reviews = List();
    stringer = List();
    _usersData = FirebaseFirestore.instance.collection('reviews');
    if (_usersData != null) {
      QuerySnapshot data = await _usersData.get();
      for (QueryDocumentSnapshot item in data.docs) {
        Reviews currUser = Reviews.withID(item.reference, item.get("reviewername"),
            item.get("restaurantname"), item.get("review"), item.get("stars"));
        reviews.add(currUser);
      }
    }
    setState(() {});
  }

  void refresh() {
    load();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (reviews == null) {
      load();
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Review"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300.00,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage('assets/logo/logo.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              )),
          SizedBox(height: 50),
          Container(
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
                  })),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RestaurantScreen()));
            },
            child: Text("Add Restaurant"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ReviewerScreen()));
            },
            child: Text("Add Reviewer"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddReviewScreen(this)));
            },
            child: Text("Add Review"),
          ),
        ]),
      ),
    );
  }
}
