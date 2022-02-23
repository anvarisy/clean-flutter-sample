
import 'package:crud_stadandri/app/dialogs/dialogs.dart';
import 'package:crud_stadandri/app/dialogs/home/user_create_dialog.dart';
import 'package:crud_stadandri/app/dialogs/home/user_update_dialog.dart';
import 'package:crud_stadandri/app/pages/home/home_presenter.dart';
import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeController extends Controller {
  List<User> _users;
  RequestState _getUsersState;

  List<User> get users => _users;
  RequestState get usersState => _getUsersState;

  final HomePresenter homePresenter;
  HomeController(UserRepository userRepo)
      : _users = [],
        _getUsersState = RequestState.none,
        homePresenter = HomePresenter(userRepo),
        super();

  @override
  void initListeners() {
    homePresenter.getUsers = (users) {
      _users = users;
    };
    homePresenter.getUsersState = (state) {
      _getUsersState = state;
      refreshUI();
    };
    homePresenter.createUserStatus = (status) {
      if (status == RequestStatus.success) {
        doGetUsers();
      }
      else if (status == RequestStatus.loading) {
        ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      }
      else {
        ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menambah data')));
      }
    };
    homePresenter.updateUserStatus = (state) {
      if (state == RequestStatus.success) {
        doGetUsers();
      }
      else if (state == RequestStatus.loading) {
        ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      }
      else {
        ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah data')));
      }
    };
    homePresenter.deleteUserStatus = (state) {
      if (state == RequestStatus.success) {
        doGetUsers();
      }
      else if (state == RequestStatus.loading) {
        ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      }
      else {
        ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus data')));
      }
    };
  }

  void doGetUsers() => homePresenter.doGetUsers();
  void doCreateUser() => showDialog(context: getContext(), builder: (c) => UserCreateDialog(
      onSave: (User user) {
        homePresenter.doCreateUser(user);
      },
    ));
  void doUpdateUser(User user) => showDialog(context: getContext(), builder: (c) => UserUpdateDialog(
      onSave: (User user) {
        homePresenter.doUpdateUser(user);
      },
      user: user,
    ));
  void doDeleteUser(int id) => showDialog(context: getContext(), builder: (c) => DeleteDialog(
      showDeleted: () => [id.toString()],
      onSave: () {
        homePresenter.doDeleteUser(id);
      },
    ));

  @override
  void onInitState() {
    homePresenter.doGetUsers();
  }

  @override
  void onDisposed() {
    homePresenter.dispose();
    super.onDisposed();
  }
}