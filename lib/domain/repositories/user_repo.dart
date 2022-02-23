
import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getUserDetail(int id);
  Future<RequestStatus> createUser(User user);
  Future<RequestStatus> updateUser(User user);
  Future<RequestStatus> deleteUser(int id);
}