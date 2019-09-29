import 'package:financial/application.dart';
import 'package:financial/model/user.dart';

class UserService {
  static createUser(User user) async {
    return Application.dio.post('user', data: user);
  }
}
