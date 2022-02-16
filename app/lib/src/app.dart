import 'package:app/src/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink link = HttpLink(
  'http://localhost:4000/graphql',
);

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    ),
  );

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: theme,
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.black87),
            titleTextStyle: theme.bodyText1,
          ),
        ),
        home: HomePage(client: client),
      ),
    );
  }
}
