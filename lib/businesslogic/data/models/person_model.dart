// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  int? id;
  String name;
  int age;
  List<PersonModel?> children;

  PersonModel({
    this.id,
    required this.name,
    required this.age,
    this.children = const [],
  });

  @override
  List<Object?> get props => [name, age, children, id];

  PersonModel copyWith({
    int? id,
    String? name,
    int? age,
    List<PersonModel?>? children,
  }) {
    return PersonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      children: children ?? this.children,
    );
  }
}
