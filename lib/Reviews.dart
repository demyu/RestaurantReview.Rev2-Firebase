class Reviews {
  String _reviewer, _restaurant, _review;
  var _id, _stars;
  Reviews(this._reviewer, this._restaurant, this._review, this._stars);
  Reviews.withID(this._id, this._reviewer, this._restaurant, this._review, this._stars);

  Reviews.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._reviewer = data['reviewername'];
    this._restaurant = data['restaurantname'];
    this._review = data['review'];
    this._stars = data['stars'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'reviewername': this._reviewer,
      'restaurantname': this._restaurant,
      'review': this._review,
      'stars': this._stars
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  int getId() {
    return this._id;
  }

  int getStars(){
    return this._stars;
  }

  String getReviewer() {
    return this._reviewer;
  }

  String getRestaurant() {
    return this._restaurant;
  }

  String getReview() {
    return this._review;
  }
}
