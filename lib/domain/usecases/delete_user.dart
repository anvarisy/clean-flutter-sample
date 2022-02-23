
import 'dart:async';

import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeleteUserUseCase extends UseCase<DeleteUserUseCaseResponse, DeleteUserUseCaseParams> {
  final UserRepository userRepository;

  DeleteUserUseCase(this.userRepository);

  @override
  Future<Stream<DeleteUserUseCaseResponse?>> buildUseCaseStream(DeleteUserUseCaseParams? params) async {
    final controller = StreamController<DeleteUserUseCaseResponse>();
    try {
      final response = await userRepository.deleteUser(params!.id);
      controller.add(DeleteUserUseCaseResponse(response));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class DeleteUserUseCaseParams {
  final int id;
  DeleteUserUseCaseParams(this.id);
}

class DeleteUserUseCaseResponse {
  final RequestStatus responseMessage;
  DeleteUserUseCaseResponse(this.responseMessage);
}