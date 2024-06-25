class UserModel {
  final String uid;
  final String name;
  final String? image;
  final String email;

  UserModel(
      {required this.uid,
      required this.name,
      required this.image,
      required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        name: json['name'],
        image: json['image'] == "" ? null : json['image'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'name': name, 'image': image, 'email': email};
  }
}
