import 'package:app/src/screens/home_page.dart';
import 'package:app/src/services/query_data.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _profesionalController = TextEditingController();
  final _ageController = TextEditingController();

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a User',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Mutation(
                options: MutationOptions(
                  document: gql(QueryData.insertUser()),
                  fetchPolicy: FetchPolicy.noCache,
                  onCompleted: (data) {
                    setState(() {
                      _isSaving = true;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                        (route) => false,
                      );
                    });
                  },
                ),
                builder: (runMutation, result) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextLabelUser(textLabel: 'Name'),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name cannot be empty';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        const TextLabelUser(textLabel: 'Profession'),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _profesionalController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your profession',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Profession cannot be empty';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        const TextLabelUser(
                          textLabel: 'Age',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your age',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Age cannot be empty';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        ButtonBar(
                          children: <Widget>[
                            TextButton(
                              child: const Text('Back'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            _isSaving
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                : TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.indigo,
                                      ),
                                    ),
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isSaving = true;
                                        });
                                        runMutation({
                                          'name': _nameController.text.trim(),
                                          'profession': _profesionalController
                                              .text
                                              .trim(),
                                          'age': int.parse(
                                              _ageController.text.trim()),
                                        });
                                      }
                                    },
                                  ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextLabelUser extends StatelessWidget {
  const TextLabelUser({
    Key? key,
    required this.textLabel,
  }) : super(key: key);

  final String textLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      textLabel,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
