import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nested_layered_task/businesslogic/models.dart';

part 'add_person_event.dart';
part 'add_person_state.dart';

class AddPersonBloc extends Bloc<PersonEvent, AddPersonState> {
  AddPersonBloc() : super(AddPersonState.initial()) {
    on<AddPersonEvent>((event, emit) {
      emit(state.copyWith(status: AddPersonStatus.loading));
      final PersonModel personModel = event.person;
      personModel.id = state.persons.length;
      emit(state.copyWith(status: AddPersonStatus.loaded, persons: [...state.persons, personModel]));
    });
    on<EditPersonEvent>((event, emit) {
      emit(state.copyWith(status: AddPersonStatus.loading));
      int editIndex = state.persons.indexWhere((element) => element.id == event.edittedPerson.id);
      state.persons[editIndex].name = event.edittedPerson.name;
      state.persons[editIndex].age = event.edittedPerson.age;
      emit(state.copyWith(status: AddPersonStatus.loaded, persons: [...state.persons]));
    });
  }
}
