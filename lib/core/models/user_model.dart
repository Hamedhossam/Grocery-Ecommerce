class UserModel {
  String? id;
  String? email;
  String? username;
  String? phone;
  String? image;
  String? address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.image,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'image': image,
      'address': address
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      image: map['image'],
      address: map['address'],
    );
  }
}
