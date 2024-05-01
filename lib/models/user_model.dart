import 'dart:convert';

class User {
  final String id;
  final String name;
  final String username;
  final String token;
  final int role;
  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.token,
      required this.role});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      token: map['token'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
