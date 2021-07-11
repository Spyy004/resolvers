class ExistingUser {
  Null expiry;
  String token;
  User user;
  String email;

  ExistingUser({this.expiry, this.token, this.user, this.email});

  ExistingUser.fromJson(Map<String, dynamic> json) {
    expiry = json['expiry'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiry'] = this.expiry;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['email'] = this.email;
    return data;
  }
}

class User {
  String username;

  User({this.username});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }
}
