import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nested_layered_task/businesslogic/models.dart';

part 'add_person_event.dart';
part 'add_person_state.dart';

class AddPersonBloc extends Bloc<PersonEvent, AddPersonState> {
  AddPersonBloc() : super(AddPersonState.initial()) {
    on<AddPersonEvent>((event, emit) {
      emit(state.copyWith(status: AddingPersonStatus.loading));
      final PersonModel personModel = event.person;
      personModel.id = UniqueKey().hashCode;
      emit(state.copyWith(status: AddingPersonStatus.loaded, persons: [...state.persons, personModel]));
    });
    on<AddNestedChildEvent>((event, emit) {
      try {
        emit(state.copyWith(status: AddingPersonStatus.loading));
        final List<PersonModel?> persons = _addChild(state.persons, event.parentId, event.nestedChild);
        persons.removeWhere((element) => element == null);
        // int selectedIndex = state.persons.indexWhere((element) => element.id == event.nestedChild.id);
        // state.persons[selectedIndex].children.add(event.nestedChild);
        emit(state.copyWith(status: AddingPersonStatus.loaded, persons: [...persons]));
      } catch (e) {
        emit(state.copyWith(status: AddingPersonStatus.error, message: e.toString()));
      }
    });
  }
  _addChild(List<PersonModel?> persons, int parentId, PersonModel nestedChild) {
    final list = persons.map((person) {
      if (person!.id == parentId) {
        if (person.children.isEmpty) {
          person.children = [nestedChild];
        } else {
          person.children = [...person.children, nestedChild];
        }
        return person;
        // person.copyWith(children: [...person.children ?? const [], nestedChild]);
      } else if (person.children.isNotEmpty) {
        return person.copyWith(children: _addChild(person.children, parentId, nestedChild));
      }
    }).toList();
    return list;
  }
}
