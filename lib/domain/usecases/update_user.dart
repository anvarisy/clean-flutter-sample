
import 'dart:async';

import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class UpdateUserUseCase extends UseCase<UpdateUserUseCaseResponse, UpdateUserUseCaseParams> {
  final UserRepository userRepository;

  UpdateUserUseCase(this.userRepository);

  @override
  Future<Stream<UpdateUserUseCaseResponse?>> buildUseCaseStream(UpdateUserUseCaseParams? params) async {
    final controller = StreamController<UpdateUserUseCaseResponse>();
    try {
      final response = await userRepository.updateUser(params!.user);
      controller.add(UpdateUserUseCaseResponse(response));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class UpdateUserUseCaseParams {
  final User user;
  UpdateUserUseCaseParams(this.user);
}

class UpdateUserUseCaseResponse {
  final RequestStatus responseMessage;
  UpdateUserUseCaseResponse(this.responseMessage);
}