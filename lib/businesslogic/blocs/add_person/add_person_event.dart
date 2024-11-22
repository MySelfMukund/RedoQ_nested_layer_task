// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_person_bloc.dart';

abstract class PersonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddPersonEvent extends PersonEvent {
  final PersonModel person;

  AddPersonEvent({required this.person});

  @override
  List<Object> get props => [person];
}

class AddNestedChildEvent extends PersonEvent {
  final PersonModel nestedChild;
  final int parentId;

  AddNestedChildEvent({
    required this.nestedChild,
    required this.parentId,
  });

  @override
  List<Object> get props => [nestedChild, parentId];

  @override
  String toString() => 'AddNestedChildEvent(nestedChild: $nestedChild, parentId: $parentId)';
}
