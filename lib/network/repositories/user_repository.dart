import '../../models/users_respone_model.dart';
import '../../utils/constants.dart';
import '../api_client.dart';

class UserRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final UserRepository _userRepository = UserRepository._internal();

  UserRepository._internal();

  factory UserRepository() {
    return _userRepository;
  }

  //Get user repository
  void getUserMeAPI(
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
