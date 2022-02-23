
import 'dart:async';

import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreateUserUseCase extends UseCase<CreateUserUseCaseResponse, CreateUserUseCaseParams> {
  final UserRepository userRepository;

  CreateUserUseCase(this.userRepository);

  @override
  Future<Stream<CreateUserUseCaseResponse?>> buildUseCaseStream(CreateUserUseCaseParams? params) async {
    final controller = StreamController<CreateUserUseCaseResponse>();
    try {
      final response = await userRepository.createUser(params!.user);
      controller.add(CreateUserUseCaseResponse(response));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class CreateUserUseCaseParams {
  final User user;
  CreateUserUseCaseParams(this.user);
}

class CreateUserUseCaseResponse {
  final RequestStatus responseMessage;
  CreateUserUseCaseResponse(this.responseMessage);
}