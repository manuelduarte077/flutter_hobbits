import 'package:app/src/screens/home_page.dart';
import 'package:app/src/widgets/label_user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'update_user_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List users = [];

  final String _query = """
      query {
          users{
            name
            id
            profession
            age
          }
        } 
      """;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(_query)),
      builder: (result, {refetch, fetchMore}) {
        if (result.isLoading) {
          return const CircularProgressIndicator();
        }
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        users = result.data!['users'];

        return (users.isNotEmpty)
            ? ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 15,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10,
                            offset: const Offset(0, 10),
                          )
                        ]),
                    padding: const EdgeInsets.all(16),
                    child: InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${user['name']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.indigoAccent,
                                    ),
                                    onTap: () async {
                                      final route = MaterialPageRoute(
                                        builder: (context) {
                                          return UpdateUser(
                                            id: user['id'],
                                            name: user['name'],
                                            profession: user['profession'],
                                            age: user['age'],
                                          );
                                        },
                                      );
                                      await Navigator.push(context, route);
                                    },
                                  ),
                                  Mutation(
                                    options: MutationOptions(
                                      document: gql(_removeUSer()),
                                      onCompleted: (data) {
                                        if (data == null) {
                                          print('error');
                                        } else {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const HomePage();
                                              },
                                            ),
                                            (route) => false,
                                          );

                                          print(
                                              "User removed: " + user['name']);
                                        }
                                      },
                                    ),
                                    builder: (runMutation, result) {
                                      return InkWell(
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                        onTap: () async {
                                          runMutation({'id': user['id']});
                                        },
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          LabelUsers(
                            user: "Occupation: ${user["profession"] ?? 'N/A'}",
                          ),
                          LabelUsers(
                            user: "Age: ${user["age"] ?? 'N/A'}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text("No users found"));
      },
    );
  }
}

String _removeUSer() {
  return """
      mutation RemoveUser(\$id: String!) {
        removeUser(id: \$id) {
          name
        }
      }
    """;
}
