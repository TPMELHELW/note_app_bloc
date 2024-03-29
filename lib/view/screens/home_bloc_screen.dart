import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/notes/notes_bloc.dart';
import 'package:note_app_bloc/view/screens/add_screen.dart';
import 'package:note_app_bloc/view/screens/home_screen.dart';

class HomeBlocScreen extends StatelessWidget {
  const HomeBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        if (state is NotesStateInAddTaskOrNotes) {
          return const AddScreen(
            isEdit: false,
          );
        } else if (state is NotesStateNoteOrTaskAdded ||
            state is NotesStateNoteOrTaskdDeleted) {
          return const HomeScreen();
        } else if (state is NotesStateInEditScreen) {
          return AddScreen(
            isEdit: true,
            note: state.notes,
          );
        }
        return Container();
      },
    );
  }
}
