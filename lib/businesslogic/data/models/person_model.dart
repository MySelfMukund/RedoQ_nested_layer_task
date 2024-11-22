import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  int? id;
  String name;
  int age;
  List<PersonModel> children;

  PersonModel({
    this.id,
    required this.name,
    required this.age,
    this.children = const [],
  });

  @override
  List<Object?> get props => [name, age, children, id];
}
