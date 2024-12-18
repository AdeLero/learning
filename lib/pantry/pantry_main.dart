import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_learning/pantry/screens/add_ingredient.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const PantryApp());
}

class PantryApp extends StatelessWidget {
  const PantryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pantry App",
      home: AddIngredient(),
    );
  }
}
