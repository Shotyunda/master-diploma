import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:doctor/models/models.dart';

class AuthApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;
  SharedPreferences storage;

  AuthApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<User> signup({
    @required String email,
    @required String password,
  }) async {
    final url = '$baseUrl/auth/signup';
    try {
      final response = await this.httpClient.post(
          url,
          body: json.encode({'email': email, 'password': password, 'type': 'doctor'}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }
      );
      if (response.statusCode != 201) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData['message'] is List<dynamic>) {
          throw HttpException(responseData['message'][0]['constraints']['matches']);
        }
        throw HttpException(responseData['message']);
      }
      return await signin(email: email, password: password);
    } catch (error) {
      throw error;
    }
  }

  Future<User> signin({
    @required String email,
    @required String password,
  }) async {
    final url = '$baseUrl/auth/signin';
    try {
      final response = await this.httpClient.post(
          url,
          body: json.encode({'email': email, 'password': password,}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }
      );
      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] is List<dynamic>) {
          throw HttpException(
              responseData['message'][0]['constraints']['matches']);
        }
        throw HttpException(responseData['message']);
      }
      final data = json.decode(response.body);
      return User(
        id: data['userId'],
        token: data['accessToken'],
        filled: data['filled'],
        doctor_info: data['doctor_info'],
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteToken() async {
    storage = await SharedPreferences.getInstance();
    storage.remove('token');
    storage.remove('id');
    storage.remove('filled');
    storage.remove('doctor_info');
    return;
  }

  Future<void> persistId(int id) async {
    storage = await SharedPreferences.getInstance();
    storage.setString('id', id.toString());
    return;
  }

  Future<void> persistToken(String token) async {
    storage = await SharedPreferences.getInstance();
    storage.setString('token', token);
    return;
  }

  Future<void> fillAccount(String fill) async {
    storage = await SharedPreferences.getInstance();
    storage.setString('filled', fill);
    return;
  }

  Future<void> persistInfo(User user) async {
    storage = await SharedPreferences.getInstance();
    storage.setString('id', user.id.toString());
    storage.setString('token', user.token);
    storage.setString('filled', user.filled.toString());
    storage.setString('doctor_info', user.doctor_info.toString());
    return;
  }

  Future<bool> hasToken() async {
    storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    return token != null;
  }

  Future<User> getUser() async {
    storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    String id = storage.getString('id');
    String filled = storage.getString('filled');
    String doctor_info = storage.getString('doctor_info');

    if (token == null) return User(
      id: 0,
      token: null,
      filled: false,
      doctor_info: null,
    );

    return User(
      id: int.parse(id),
      token: token,
      filled: filled == 'true',
      doctor_info: int.parse(doctor_info),
    );
  }
}
