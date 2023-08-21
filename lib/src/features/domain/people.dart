// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Gender { pria, wanita }

class People {
  final String nik;
  final String fullname;
  final String handphone;
  final String createdAt;
  final String address;
  final String image;
  final String gender;

  People({
    required this.nik,
    required this.fullname,
    required this.handphone,
    required this.createdAt,
    required this.address,
    required this.image,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nik': nik,
      'fullname': fullname,
      'handphone': handphone,
      'createdAt': createdAt,
      'address': address,
      'image': image,
      'gender': gender,
    };
  }

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      nik: map['nik'] as String,
      fullname: map['fullname'] as String,
      handphone: map['handphone'] as String,
      createdAt: map['createdAt'] as String,
      address: map['address'] as String,
      image: map['image'] as String,
      gender: map['gender'] == 'PRIA' ? 'Pria' : 'Wanita',
    );
  }

  String toJson() => json.encode(toMap());

  factory People.fromJson(String source) => People.fromMap(json.decode(source) as Map<String, dynamic>);
}
