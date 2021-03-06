import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'add_user_page.dart';
import 'users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.client}) : super(key: key);

  final ValueNotifier<GraphQLClient>? client;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    Widget content = const UsersPage();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hobbits',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.mcLaren().fontFamily,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(child: content),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => const AddUserPage(),
          );
          await Navigator.push(context, route);
        },
        backgroundColor: Colors.indigoAccent,
        child: const Icon(Icons.group_add_outlined),
      ),
    );
  }
}
