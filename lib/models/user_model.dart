class UserModel {
  String? email;
  String? uid;

  UserModel({
    this.email,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email ?? '',
      "uid": uid ?? '',
    };
  }
}
