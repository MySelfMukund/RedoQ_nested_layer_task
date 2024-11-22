// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'add_person_bloc.dart';

enum AddPersonStatus { initial, loading, loaded }

class AddPersonState extends Equatable {
  final AddPersonStatus status;
  final List<PersonModel> persons;

  const AddPersonState({
    required this.status,
    required this.persons,
  });

  factory AddPersonState.initial() {
    return const AddPersonState(
      status: AddPersonStatus.initial,
      persons: [],
    );
  }

  @override
  List<Object> get props => [status, persons];

  @override
  bool get stringify => true;

  AddPersonState copyWith({
    AddPersonStatus? status,
    List<PersonModel>? persons,
  }) {
    return AddPersonState(
      status: status ?? this.status,
      persons: persons ?? this.persons,
    );
  }
}
