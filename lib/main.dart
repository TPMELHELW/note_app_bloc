import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/auth/auth_bloc.dart';
import 'package:note_app_bloc/bloc/notes/notes_bloc.dart';
import 'package:note_app_bloc/core/repo/auth_repository.dart';
import 'package:note_app_bloc/core/repo/home_repository.dart';
import 'package:note_app_bloc/firebase_options.dart';
import 'package:note_app_bloc/view/screens/auth_bloc_screen.dart';
import 'package:note_app_bloc/view/screens/home_bloc_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => HomeRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: AuthRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => NotesBloc(
              homeRepository: HomeRepository(),
            ),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthBlocScreen(),
        ),
      ),
    );
  }
}
