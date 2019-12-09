import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/university/university_api_client.dart';
import 'package:meta/meta.dart';

class UniversityRepository {
  final UniversityApiClient universityApiClient;

  UniversityRepository({@required this.universityApiClient})
      : assert(universityApiClient != null);

  Future<List<University>> list({@required String token}) async {
    return await universityApiClient.list(token: token);
  }
}
