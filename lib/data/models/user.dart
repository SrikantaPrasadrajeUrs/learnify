class User {
  final String userName;
  final String id;
  final String email;
  final String fullName;
  final String avatarUrl;
  final String cart;

  User({
    required this.userName,
    required this.id,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.cart,
  });

  // Convert a Map (JSON) to a User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['username'] as String,
      id: json['_id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatar'] as String,
      cart: json['cart'] as String,
    );
  }

  // Convert a User instance to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      '_id': id,
      'email': email,
      'fullName': fullName,
      'avatar': avatarUrl,
      'cart': cart,
    };
  }

  // CopyWith method to create a new instance with modified values
  User copyWith({
    String? userName,
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    String? cart,
  }) {
    return User(
      userName: userName ?? this.userName,
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      cart: cart ?? this.cart,
    );
  }
}
