import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
                        borderRadius: BorderRadius.circular(5),
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
                                      color: Colors.green,
                                    ),
                                    onTap: () async {},
                                  ),
                                  InkWell(
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onTap: () async {},
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

class LabelUsers extends StatelessWidget {
  const LabelUsers({
    Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Text(user),
    );
  }
}
