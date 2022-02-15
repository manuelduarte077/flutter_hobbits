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
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 23, left: 10, right: 10),
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
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${user['name']}",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )
              : const Center(
                  child: Text("No users found"),
                );
        });
  }
}
