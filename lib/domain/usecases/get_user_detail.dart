
import 'dart:async';

import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetUserDetailUseCase extends UseCase<GetUserDetailUseCaseResponse, GetUserDetailUseCaseParams> {
  final UserRepository userRepository;

  GetUserDetailUseCase(this.userRepository);

  @override
  Future<Stream<GetUserDetailUseCaseResponse?>> buildUseCaseStream(GetUserDetailUseCaseParams? params) async {
    final controller = StreamController<GetUserDetailUseCaseResponse>();
    try {
      final user = await userRepository.getUserDetail(params!.id);
      controller.add(GetUserDetailUseCaseResponse(user));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetUserDetailUseCaseParams {
  final int id;
  GetUserDetailUseCaseParams(this.id);
}

class GetUserDetailUseCaseResponse {
  final User user;
  GetUserDetailUseCaseResponse(this.user);
}