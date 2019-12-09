import 'dart:io';
import 'package:doctor/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class NotesApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;

  NotesApiClient({this.httpClient});

  Future<List<Notes>> fetch({String token, String id}) async {
    final String url = '$baseUrl/notes?doctor=$id';
    try {
      final response = await httpClient.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      print(response.body);
      if (response.statusCode != 200) {
        throw HttpException(response.body.toString());
      }
      final data = jsonDecode(response.body);
      return data.map<Notes>((record) {
        return Notes.fromJson(record);
      }).toList();
    } catch(error) {
      throw error;
    }
  }

  Future<Notes> create({String token, dynamic record}) async {
    final String url = '$baseUrl/notes';
    try {
      final response = await httpClient.post(
          url,
          body: jsonEncode(record),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      print(response.statusCode);
      if (response.statusCode != 201) {
        throw HttpException(response.body.toString());
      }
      final data = jsonDecode(response.body);
      return Notes.fromJson(data);
    } catch(error) {
      throw error;
    }
  }

  Future<void> remove({String token, String id}) async {
    final String url = '$baseUrl/notes/$id';
    try {
      final response = await httpClient.delete(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      if (response.statusCode != 200) {
        throw HttpException(response.body.toString());
      }
    } catch(error) {
      throw error;
    }
  }
}
