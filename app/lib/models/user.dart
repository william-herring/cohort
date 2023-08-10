class User {
  final String userId;
  final String name;
  final String email;
  final String? avatar;
  final String role;

  User(this.userId, this.role, this.name, this.email, this.avatar);

  User.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        name = json['name'],
        email = json['email'],
        avatar = json['avatar'],
        role = json['role'];
}