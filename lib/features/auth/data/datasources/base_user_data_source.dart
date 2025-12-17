
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';

abstract class BaseUserDataSource {
  Future<void> saveUserRecord(UserModel userModel);
}
