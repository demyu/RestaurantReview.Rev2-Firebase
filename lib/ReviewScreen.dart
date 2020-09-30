import 'package:flutter/material.dart';
import 'Reviews.dart';

class ReviewScreen extends StatefulWidget {
  var review;
  ReviewScreen({this.review});
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    int stars = widget.review.getStars();
    var pic;
    switch (stars) {
      case 1:
        pic = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/stars/one.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
      case 2:
        pic = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/stars/two.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
      case 3:
        pic = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/stars/three.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
      case 4:
        pic = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/stars/four.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
      case 5:
        pic = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/stars/five.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Review"),
        ),
        body: Column(children: [
          pic,
          Center(child: Text(widget.review.getReview())),
          RaisedButton(
            onPressed: () {
              
              Navigator.pop(context);
            },
            child: Text("Back"),
          )
        ]));
  }
}
