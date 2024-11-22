import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested_layered_task/businesslogic/blocs.dart';
import 'package:nested_layered_task/businesslogic/blocs/add_person/add_person_bloc.dart';

import 'package:nested_layered_task/businesslogic/models.dart';

class AddEditPersonPage extends StatefulWidget {
  static const String routeName = '/add_edit_person_page';
  final PersonModel? personModel;

  const AddEditPersonPage({super.key, this.personModel});
  @override
  State<AddEditPersonPage> createState() => _AddEditPersonPageState();
}

class _AddEditPersonPageState extends State<AddEditPersonPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.personModel != null) {
      nameController.text = widget.personModel!.name;
      ageController.text = widget.personModel!.age.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _saveAndUpdatePerson() async {
    if (_formKey.currentState!.validate()) {
      final person = PersonModel(
        name: nameController.text,
        age: int.tryParse(ageController.text)!,
        id: widget.personModel?.id,
      );
      if (widget.personModel != null) {
        context.read<AddPersonBloc>().add(EditPersonEvent(edittedPerson: person));
      } else {
        context.read<AddPersonBloc>().add(AddPersonEvent(person: person));
      }
      dataClear();
      Navigator.pop(context);
    }
  }

  void dataClear() {
    nameController.clear();
    ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.personModel == null ? 'Add' : 'Update',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                buildNameControllerTextBoxWidget(),
                const SizedBox(height: 20),
                const Text('Age', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                buildAgeControllerTextWidget(),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => _saveAndUpdatePerson(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      widget.personModel == null ? 'Submit' : 'Update',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAgeControllerTextWidget() {
    return TextFormField(
      controller: ageController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter your age',
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
      validator: (value) => value!.isEmpty ? 'Enter your age' : null,
    );
  }

  Widget buildNameControllerTextBoxWidget() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Enter your name',
        border: OutlineInputBorder(),
      ),
      autofocus: true,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      validator: (value) => value!.isEmpty ? 'Enter your name' : null,
    );
  }
}
