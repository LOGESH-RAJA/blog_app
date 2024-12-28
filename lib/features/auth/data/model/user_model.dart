import 'package:blog_app/core/common/entities/users.dart';

class UserModel extends UsersEntity {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        name: json['name'] ?? '');
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
        id: id ?? this.id, email: email ?? this.email, name: name ?? this.name);
  }
}
