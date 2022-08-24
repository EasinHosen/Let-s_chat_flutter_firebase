class UserModel{
  String? uid, name, email, mobile, image, deviceToken;
  bool available;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.mobile,
      this.image,
      this.deviceToken,
      this.available = true
      });

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'uid': uid,
      'name': name,
      'email': email,
      'mobile': mobile,
      'image': image,
      'deviceToken': deviceToken,
      'available': available,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map ) => UserModel(
    uid: map['uid'],
    name: map['name'],
    email: map['email'],
    mobile: map['mobile'],
    image: map['image'],
    deviceToken: map['deviceToken'],
    available: map['available'],
  );
}