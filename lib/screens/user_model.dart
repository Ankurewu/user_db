import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserDetailsModel extends HiveObject {
  @HiveField(0)
  late String address;

  @HiveField(1)
  late String bloodgroup;

  @HiveField(2)
  late String mobilenumber;
   @HiveField(3)
  late String nId;
   @HiveField(4)
  late String name;

  @HiveField(5)
  late String email;

  @HiveField(6)
  late String password;

  @HiveField(7)
  final String? image;
  


  UserDetailsModel({
    required this.address,
    required this.bloodgroup,
    required this.mobilenumber,
    required this.nId,
    required this.name,
    required this.email,
    required this.password,
     this.image,
  });
}

