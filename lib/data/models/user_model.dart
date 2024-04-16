class Users {
  final String email;
  final String password;

  Users({
    required this.email,
    required this.password,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() => {
    "email":email,
    "password":password
  };
}
