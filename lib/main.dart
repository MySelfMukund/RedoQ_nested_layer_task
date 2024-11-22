import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested_layered_task/businesslogic/blocs/add_person/add_person_bloc.dart';
import 'package:nested_layered_task/core/app_router/app_router.dart';
import 'package:nested_layered_task/core/bloc_observer.dart';

import 'businesslogic/blocs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<PersonBloc>(create: (context) => PersonBloc()),
        BlocProvider<AddPersonBloc>(create: (context) => AddPersonBloc()),
      ],
      child: MaterialApp(
        title: 'Nested Layered Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
