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

class EditPersonEvent extends PersonEvent {
  final PersonModel edittedPerson;

  EditPersonEvent({
    required this.edittedPerson,
  });

  @override
  List<Object> get props => [edittedPerson];
}
