
import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:crud_stadandri/domain/usecases/create_user.dart';
import 'package:crud_stadandri/domain/usecases/delete_user.dart';
import 'package:crud_stadandri/domain/usecases/get_users.dart';
import 'package:crud_stadandri/domain/usecases/update_user.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  late Function(List<User> user) getUsers;
  late Function(RequestState state) getUsersState;

  late Function(RequestStatus status) createUserStatus;
  late Function(RequestStatus status) updateUserStatus;
  late Function(RequestStatus status) deleteUserStatus;

  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  HomePresenter(UserRepository userRepo) : getUsersUseCase = GetUsersUseCase(userRepo),
        createUserUseCase = CreateUserUseCase(userRepo),
        updateUserUseCase = UpdateUserUseCase(userRepo),
        deleteUserUseCase = DeleteUserUseCase(userRepo);

  void doGetUsers() {
    getUsersState(RequestState.loading);
    getUsersUseCase.execute(
        _GetUsersUseCaseObserver(this), GetUsersUseCaseParams()
    );
  }

  void doCreateUser(User user) {
    createUserStatus(RequestStatus.loading);
    createUserUseCase.execute(
        _CreateUserUseCaseObserver(this), CreateUserUseCaseParams(user)
    );
  }

  void doUpdateUser(User user) {
    updateUserStatus(RequestStatus.loading);
    updateUserUseCase.execute(
        _UpdateUserUseCaseObserver(this), UpdateUserUseCaseParams(user)
    );
  }

  void doDeleteUser(int id) {
    deleteUserStatus(RequestStatus.loading);
    deleteUserUseCase.execute(
        _DeleteUserUseCaseObserver(this), DeleteUserUseCaseParams(id)
    );
  }

  @override
  void dispose() {
    getUsersUseCase.dispose();
    createUserUseCase.dispose();
  }
}

class _GetUsersUseCaseObserver implements Observer<GetUsersUseCaseResponse> {
  HomePresenter presenter;

  _GetUsersUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.getUsersState(RequestState.error);
  }

  @override
  void onNext(GetUsersUseCaseResponse? response) {
    presenter.getUsers(response!.users);
    presenter.getUsersState((response.users.isNotEmpty)
        ? RequestState.loaded
        : RequestState.none
    );
  }
}

class _CreateUserUseCaseObserver implements Observer<CreateUserUseCaseResponse> {
  HomePresenter presenter;

  _CreateUserUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.createUserStatus(RequestStatus.failed);
  }

  @override
  void onNext(CreateUserUseCaseResponse? response) {
    presenter.createUserStatus(response!.responseMessage);
  }
}

class _UpdateUserUseCaseObserver implements Observer<UpdateUserUseCaseResponse> {
  HomePresenter presenter;

  _UpdateUserUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.updateUserStatus(RequestStatus.failed);
  }

  @override
  void onNext(UpdateUserUseCaseResponse? response) {
    presenter.updateUserStatus(response!.responseMessage);
  }
}

class _DeleteUserUseCaseObserver implements Observer<DeleteUserUseCaseResponse> {
  HomePresenter presenter;

  _DeleteUserUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.deleteUserStatus(RequestStatus.failed);
  }

  @override
  void onNext(DeleteUserUseCaseResponse? response) {
    presenter.deleteUserStatus(response!.responseMessage);
  }
}