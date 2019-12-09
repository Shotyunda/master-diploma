import 'dart:io';
import 'package:doctor/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class UniversityApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;

  UniversityApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<University>> list({@required String token}) async {
    String url = '$baseUrl/university';
    List<University> universityList = [];
    try {
      final response = await httpClient.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      final universities = json.decode(response.body);
      for (var university in universities) {
        universityList.add(University.fromJson(university));
      }
      return universityList;
    } catch(error) {
      throw error;
    }
  }
}
