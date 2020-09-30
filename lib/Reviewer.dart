class Reviewer {
  String _name;
  var _id;
  Reviewer(this._name);
  Reviewer.withID(this._id, this._name);
  Reviewer.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['reviewername'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'reviewername': this._name,
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  int getId() {
    return this._id;
  }

  String getUsername() {
    return this._name;
  }
}
