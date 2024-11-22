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
      body: BlocConsumer<AddPersonBloc, AddPersonState>(listener: (context, state) {
        if (state.status == AddingPersonStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.toString())));
        }
      }, builder: (context, state) {
        if (state.status == AddingPersonStatus.initial) {
          return const Center(
              child: Text(
            'No Persons found, please add one',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
        } else if (state.status == AddingPersonStatus.error) {
          return const Center(child: Text('Error occured please restart your app'));
        } else if (state.status == AddingPersonStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == AddingPersonStatus.loaded) {
          final persons = state.persons;
          if (persons.isEmpty) {
            return const Center(
              child: Text('No Data Found'),
            );
          }

          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: _buildExpansionTile(persons, context),
          );
        }
        return Container();
      }),
    );
  }

  FloatingActionButton buildFloatingActionButtonWidget(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () => Navigator.pushNamed(context, AddPersonPage.routeName),
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

  List<Widget> _buildExpansionTile(List<PersonModel?> persons, BuildContext context) {
    return persons.map((person) {
      int totalChildren = person == null ? 0 : countTotalChildren(person);
      if (person == null) {
        return Container();
      }
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
            title: buildExpansionTileTitleWidget(person, context, totalChildren >= 4),
            subtitle: Text("${person.age.toString()} Years of Old "),
            children: _buildExpansionTile(person.children, context),
          ),
        ),
      );
    }).toList();
  }

  int countTotalChildren(PersonModel? person) {
    if (person == null) {
      return 0;
    }
    int count = person.children.length; // Count direct children

    for (var child in person.children) {
      count += child != null ? countTotalChildren(child) : 0; // Recursively count descendants
    }

    return count;
  }

  Widget buildExpansionTileTitleWidget(PersonModel? person, BuildContext context, bool ischildAllowed) {
    if (person == null) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${person!.name} ", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        IconButton(
            onPressed: ischildAllowed
                ? null
                : () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPersonPage(
                              personModel: person,
                            ))),
            icon: const Icon(
              Icons.edit_square,
            ))
      ],
    );
  }
}
