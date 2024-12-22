import 'package:learnify/core/constants/api_config.dart';
import 'package:learnify/core/utils/api_endpoints.dart';
import 'package:learnify/core/utils/http_service.dart';

abstract interface class AuthRepository {
  Future<Map<String,dynamic>> signUp(String userName, String password);
  Future<Map<String,dynamic>> signIn(String userName, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Map<String,dynamic>> signUp(String userName, String password) async {
   return {};
  }

  @override
  Future<Map<String,dynamic>> signIn(String userName, String password) async {
    return await HTTPService.post('$domain${ApiEndpoints.signIn}', {
      "username":"Yasowant",
      "email":"yasowant1998@gmail.com",
      "password":"Yasowant@264"
    });
  }
}
