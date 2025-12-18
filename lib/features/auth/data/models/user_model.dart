import 'package:ecommerce_app/core/utils/formatters.dart/formatters.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String profileImage;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.profileImage,
  });

  String get formattedPhoneNo => Formatter.formatPhoneNumber(phone);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "user_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "username": username,
    "email": email,
    "password": password,
    "phone": phone,
    "profileImage": profileImage,
  };

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    username,
    email,
    password,
    phone,
    profileImage,
  ];
}
