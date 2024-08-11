import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokodek/core/injection/env.dart';
import 'package:pokodek/core/theme/app_theme.dart';
import 'package:pokodek/feature/list_pokemon/view/list_pokemon_page.dart';

// shortcut for app theme
TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;

// Set your environment here
const Environment env = Environment.development;

final HttpLink httpLink = HttpLink(env.baseURLFull);

final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(),
));

void main() async {
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        showSemanticsDebugger: false,
        title: 'Pokokdex',
        themeMode: ThemeMode.dark,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        home: const ListPokemonPage(),
      ),
    );
  }
}
