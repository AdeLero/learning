import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/blocs/ingredient_bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/blocs/meal_bloc/meal_bloc.dart';
import 'package:my_learning/pantry/blocs/meal_time_bloc/meal_time_bloc.dart';
import 'package:my_learning/pantry/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/repos/auth_repo.dart';
import 'package:my_learning/pantry/routes/screens.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  final authRepository = AuthRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authRepository),
      ),
      BlocProvider<InventoryBloc>(
        create: (_) => InventoryBloc(),
      ),
      BlocProvider<MealBloc>(
        create: (_) => MealBloc(),
      ),
      BlocProvider<MealTimeBloc>(
        create: (_) => MealTimeBloc(),
      ),
      BlocProvider<ScheduleBloc>(
        create: (context) => ScheduleBloc(
          context.read<MealTimeBloc>(),
        ),
      ),
    ],
    child: const PantryApp(),
  ));
}

class PantryApp extends StatelessWidget {
  const PantryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: "Pantry App",
          theme: pantryTheme,
          debugShowCheckedModeBanner: false,
          routes: appRoutes,
          onGenerateRoute: (settings) {
            final finalRoute = screens.firstWhere(
              (route) => route.name == settings.name,
              orElse: () =>
                  throw Exception("Route not found: ${settings.name}"),
            );
            return MaterialPageRoute(
              builder: (context) => finalRoute.page!(settings.arguments),
            );
          },
        );
      },
    );
  }
}
