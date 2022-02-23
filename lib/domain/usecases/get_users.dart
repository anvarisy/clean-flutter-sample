
import 'dart:async';

import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetUsersUseCase extends UseCase<GetUsersUseCaseResponse, GetUsersUseCaseParams> {
  final UserRepository userRepository;

  GetUsersUseCase(this.userRepository);

  @override
  Future<Stream<GetUsersUseCaseResponse?>> buildUseCaseStream(GetUsersUseCaseParams? params) async {
    final controller = StreamController<GetUsersUseCaseResponse>();
    try {
      final users = await userRepository.getUsers();
      controller.add(GetUsersUseCaseResponse(users));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetUsersUseCaseParams {}

class GetUsersUseCaseResponse {
  final List<User> users;
  GetUsersUseCaseResponse(this.users);
}