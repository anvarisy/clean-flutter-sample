
import 'dart:async';
import 'dart:convert';

import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:crud_stadandri/domain/repositories/user_repo.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl extends UserRepository {
  static final Uri _host = Uri.https('gorest.co.in', '/');
  static const String _accessToken = '01cd0879d8cfa0510bf0b095064b7c38d65cb313aa4a35f034331ad57f211207';
  static Map<String, String> _headers([String? token]) => {
    if (token!=null) 'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  //singleton
  static final UserRepositoryImpl _instance = UserRepositoryImpl._internal();
  UserRepositoryImpl._internal();
  factory UserRepositoryImpl() => _instance;

  @override
  Future<RequestStatus> createUser(User user) async {
    try {
      final response = await http.post(
        _host.replace(path: '/public/v2/users'),
        headers: _headers(_accessToken),
        body: jsonEncode({
          'name': user.name,
          'gender': user.gender,
          'email': user.email,
          'status': user.status
        }),
      ).timeout(const Duration(seconds: 7));

      if (response.statusCode == 201) {
        return RequestStatus.success;
      }
    } on TimeoutException {
      return RequestStatus.timeout;
    }

    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteUser(int id) async {
    try {
      final response = await http.delete(
        _host.replace(path: '/public/v2/users/$id'),
        headers: _headers(_accessToken),
      ).timeout(const Duration(seconds: 7));

      if (response.statusCode == 204) {
        return RequestStatus.success;
      }
    } on TimeoutException {
      return RequestStatus.timeout;
    }

    return RequestStatus.failed;
  }

  @override
  Future<User> getUserDetail(int id) async {
    try {
      final response = await http.get(
        _host.replace(path: '/public/v2/users/$id'),
        headers: _headers(_accessToken),
      ).timeout(const Duration(seconds: 7));

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      }
    } on TimeoutException {
      throw TimeoutException('');
    }

    throw Exception();
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        _host.replace(path: '/public/v2/users'),
        headers: _headers(_accessToken),
      ).timeout(const Duration(seconds: 7));

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List).map<User>((e) => User.fromJson(e)).toList();
      }
    } on TimeoutException {
      throw TimeoutException('');
    }

    throw Exception();
  }

  @override
  Future<RequestStatus> updateUser(User user) async {
    try {
      final response = await http.put(
        _host.replace(path: '/public/v2/users/${user.id}'),
        headers: _headers(_accessToken),
        body: jsonEncode({
          'name': user.name,
          'gender': user.gender,
          'email': user.email,
          'status': user.status
        }),
      ).timeout(const Duration(seconds: 7));

      if (response.statusCode == 200) {
        return RequestStatus.success;
      }
    } on TimeoutException {
      return RequestStatus.timeout;
    }

    return RequestStatus.failed;
  }

}