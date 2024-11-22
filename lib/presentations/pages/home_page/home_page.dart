import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../businesslogic/blocs.dart';
import '../../../businesslogic/models.dart';
import '../pages.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      floatingActionButton: buildFloatingActionButtonWidget(context),
      body: BlocBuilder<AddPersonBloc, AddPersonState>(builder: (context, state) {
        if (state.status == AddPersonStatus.initial) {
          return const Center(
              child: Text(
            'No Persons found, please add one',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
        } else if (state.status == AddPersonStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == AddPersonStatus.loaded) {
          final persons = state.persons;
          if (persons.isEmpty) {
            return const Center(
              child: Text('No Data Found'),
            );
          }
          final List<PersonModel> nestedPersonList = generateNestedPersons(persons);
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: _buildExpansionTile(nestedPersonList, context),
          );
        }
        return Container();
      }),
    );
  }

  FloatingActionButton buildFloatingActionButtonWidget(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () => Navigator.pushNamed(context, AddEditPersonPage.routeName),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      title: const Text(
        'Your Details',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  List<PersonModel> generateNestedPersons(List<PersonModel> persons) {
    List<PersonModel> nestedList = [];

    for (int i = 0; i < persons.length; i++) {
      if (i % 5 == 0) {
        // Parent node
        PersonModel currentParent = persons[i];
        // Add nested children
        PersonModel? lastChild = currentParent;
        for (int j = 1; j <= 4; j++) {
          // for (int j = 4; j > 1; j--) {
          if (i + j < persons.length) {
            lastChild = PersonModel(
              name: persons[i + j].name,
              age: persons[i + j].age,
              id: persons[i + j].id,
              children: lastChild == null ? [] : [lastChild],
            );
          }
        }

        // Add the fully nested structure to the list
        nestedList.add(lastChild!);
      }
    }

    return nestedList;
  }

  List<Widget> _buildExpansionTile(List<PersonModel> persons, BuildContext context) {
    return persons.map((person) {
      return Container(
        key: UniqueKey(),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Border color
          borderRadius: BorderRadius.circular(10), // Border radius),
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${person.name} ", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEditPersonPage(
                                  personModel: person,
                                ))),
                    icon: const Icon(
                      Icons.edit_square,
                    ))
              ],
            ),
            subtitle: Text("${person.age.toString()} Years of Old"),
            children: _buildExpansionTile(person.children, context),
          ),
        ),
      );
    }).toList();
  }
}
