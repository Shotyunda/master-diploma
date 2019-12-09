import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/doctor/doctor_api_client.dart';
import 'package:meta/meta.dart';

class DoctorRepository {
  final DoctorApiClient doctorApiClient;

  DoctorRepository({@required this.doctorApiClient});

  Future<Doctor> update({@required dynamic record, @required String id, @required String token}) async {
    return await doctorApiClient.update(record: record, id: id, token: token);
  }

  Future<List<Patient>> patients({@required String id, @required String token}) async {
    return await doctorApiClient.patients(id: id, token: token);
  }

  Future<Doctor> doctor({String token, String id}) async {
    return await doctorApiClient.doctor(token: token, id: id);
  }
}
