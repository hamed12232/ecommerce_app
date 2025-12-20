import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';

abstract class BaseUserDataSource {
  Future<void> saveUserRecord(UserModel userModel);
  Future<UserModel> fetchUserDetails();
  Future<void> updateUserDetails(UserModel userModel);
  Future<void> updateSingleField(Map<String, dynamic> json);
  Future<void> removeUserRecord(String userId);
}
