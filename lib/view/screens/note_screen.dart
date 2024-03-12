import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/notes/notes_bloc.dart';
import 'package:note_app_bloc/core/repo/home_repository.dart';
import 'package:note_app_bloc/view/widgets/note_view_widget.dart';
import 'package:note_app_bloc/view/widgets/task_view_widget.dart';

class TaskOrNoteScreen extends StatelessWidget {
  final String type;
  const TaskOrNoteScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    HomeRepository homeRepository = HomeRepository();
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return FutureBuilder(
          future: homeRepository.getNotes(type),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final notes = snapshot.data!;
              if (type == 'Task') {
                return TaskViewWidget(
                  notes: notes,
                );
              } else {
                return NoteViewWidget(
                  snapshot: notes,
                );
              }
            }

            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
