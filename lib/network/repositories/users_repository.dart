import '../../models/users_respone_model.dart';
import '../../utils/constants.dart';
import '../api_client.dart';

class UsersRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final UsersRepository _usersRepository = UsersRepository._internal();

  UsersRepository._internal();

  factory UsersRepository() {
    return _usersRepository;
  }

  //Get users repository
  void getUsersAPI(
      String url, ResponseCallback<UsersResponseModel?, String?> callback) {
    _apiClient.getRequest(url, (response, error) {
      if (response != null) {
        callback(UsersResponseModel.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }
}
