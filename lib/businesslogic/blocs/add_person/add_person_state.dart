// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'add_person_bloc.dart';

enum AddingPersonStatus { initial, loading, loaded, error }

class AddPersonState extends Equatable {
  final AddingPersonStatus status;
  final List<PersonModel?> persons;
  final String? message;

  const AddPersonState({
    required this.status,
    required this.persons,
    this.message,
  });

  factory AddPersonState.initial() {
    return const AddPersonState(status: AddingPersonStatus.initial, persons: [], message: '');
  }

  @override
  List<Object> get props => [status, persons, message ?? ''];

  @override
  bool get stringify => true;

  AddPersonState copyWith({
    AddingPersonStatus? status,
    List<PersonModel?>? persons,
    String? message,
  }) {
    return AddPersonState(
      status: status ?? this.status,
      persons: persons ?? this.persons,
      message: message ?? this.message,
    );
  }
}
