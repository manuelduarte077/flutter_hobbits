import 'package:app/src/screens/add_user_page.dart';
import 'package:app/src/screens/home_page.dart';
import 'package:app/src/widgets/button_style.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateUser extends StatefulWidget {
  final String id;
  final String name;
  final String profession;
  final int age;

  const UpdateUser(
      {Key? key,
      required this.id,
      required this.name,
      required this.age,
      required this.profession})
      : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _nameController = TextEditingController();
  final _professionController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _professionController.text = widget.profession;
    _ageController.text = widget.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Update ${widget.name}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Mutation(
                options: MutationOptions(
                  document: gql((_updateUser())),
                  fetchPolicy: FetchPolicy.noCache,
                  onCompleted: (data) {
                    _isSaving = false;

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ), (route) => false);
                  },
                ),
                builder: (runMutation, result) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextLabelUser(textLabel: 'Name'),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SpacingInput(),
                        const TextLabelUser(textLabel: 'Profession'),
                        const SpacingInput(),
                        TextFormField(
                          controller: _professionController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Profession cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SpacingInput(),
                        const TextLabelUser(textLabel: 'Age'),
                        const SpacingInput(),
                        TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Age cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        _isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isSaving = true;
                                    });
                                    runMutation({
                                      'id': widget.id,
                                      'name': _nameController.text
                                          .toString()
                                          .trim(),
                                      'profession':
                                          _professionController.text.trim(),
                                      'age':
                                          int.parse(_ageController.text.trim()),
                                    });
                                  }
                                },
                                child: const FittedBox(
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                style: buildButtonStyle(),
                              )
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

class SpacingInput extends StatelessWidget {
  const SpacingInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}

String _updateUser() {
  return """
    mutation UpdateUser(\$id: String!, \$name: String!, \$profession: String!, \$age: Int!) {
      updateUser(id: \$id, name: \$name, profession: \$profession, age: \$age){
        name
      }   
    }
  """;
}
