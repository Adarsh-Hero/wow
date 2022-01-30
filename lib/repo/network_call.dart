import 'package:http/http.dart' as http;
import 'package:istreamo/model/userRepo.dart';

class UserRepository {
  static Future<List<UserRepo>> getUser(int pageNumber) async {
    var userApi = UserApi();
    return await userApi.getUser(pageNumber);
  }
}

abstract class NetworkCall {
  Future<List<UserRepo>> getUser(int pageNumber);
}

class UserApi extends NetworkCall {
  @override
  Future<List<UserRepo>> getUser(int pageNumber) async {
    try {
      var uri = Uri.parse("https://api.github.com/users/JakeWharton/repos?page=$pageNumber&per_page=15");
      var response = await http.get(uri);
      var userList = usersFromJson(response.body);
      return userList;
    } catch (e) {
      print('error $e');
      return List<UserRepo>.empty();
    }
  }
}
