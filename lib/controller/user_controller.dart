import 'package:get/get.dart';
import '../models/users_respone_model.dart';
import '../network/repositories/users_repository.dart';
import '../utils/endpoints.dart';

class UsersController extends GetxController {
  late final UsersRepository _usersRepository;
  final users = <Result>[].obs;

  @override
  void onInit() {
    _usersRepository = UsersRepository();
    super.onInit();
  }

  //Get Mail controller.
  void getUsers() {
    _usersRepository.getUsersAPI(usersEndPoint, (response, error) {
      if (response != null) {
        users.value = response.results;
      } else {}
    });
  }
}
