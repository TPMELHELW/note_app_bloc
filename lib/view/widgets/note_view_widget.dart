import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/notes/notes_bloc.dart';
import 'package:note_app_bloc/core/constant/color.dart';
import 'package:note_app_bloc/core/repo/home_repository.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_text.dart';

class NoteViewWidget extends StatelessWidget {
  final snapshot;

  const NoteViewWidget({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    // HomeRepository homeRepository = HomeRepository();
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: tileColors[index % 7],
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: ListTile(
            leading: IconButton(
              onPressed: () {
                context.read<NotesBloc>().add(
                      NotesEventGoToEditNotes(notes: snapshot[index]),
                    );
              },
              icon: Icon(Icons.edit),
            ),
            trailing: IconButton(
              onPressed: () {
                // homeRepository.data.removeAt(0);
                context.read<NotesBloc>().add(
                      NotesEventDeleteTaskOrNotes(
                        id: snapshot[index].id.toString(),
                      ),
                    );
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            title: AuthText(
              text: '${snapshot[index]['title']}',
              style: FontWeight.bold,
              size: 30,
              color: Colors.black,
            ),
            subtitle: AuthText(
              text: '${snapshot[index]['body']}',
              style: FontWeight.normal,
              size: 15,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
