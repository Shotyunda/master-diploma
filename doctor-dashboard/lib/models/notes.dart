import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Notes extends Equatable {
  final String id;
  final String name;
  final String body;

  Notes({
    this.id = '',
    @required this.name,
    this.body = '',
  });

  @override
  List<Object> get props => [
    id,
    name,
  ];

  static Notes fromJson(dynamic json) {
    return Notes(
      id: json['id'].toString(),
      name: json['name'],
      body: json['body'],
    );
  }
}

