import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:note_app_bloc/core/errors/note_error.dart';
import 'package:note_app_bloc/core/repo/home_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  HomeRepository homeRepository;
  NotesBloc({
    required this.homeRepository,
  }) : super(NotesStateNoteOrTaskAdded(isLoading: false)) {
    on<NotesEventAddNoteOrTask>(
      (event, emit) async {
        emit(
          NotesStateInAddTaskOrNotes(
            isLoading: true,
          ),
        );
        try {
          await homeRepository.addData(event.title, event.body, event.selected);
          emit(
            NotesStateNoteOrTaskAdded(isLoading: false),
          );
        } on Exception catch (e) {
          emit(
            NotesStateInAddTaskOrNotes(
              isLoading: false,
              noteError: NoteError.from(e),
            ),
          );
        }
      },
    );
    on<NotesEventGoToAddNoteOrTask>(
      (event, emit) {
        emit(
          NotesStateInAddTaskOrNotes(
            isLoading: false,
          ),
        );
      },
    );
    on<NotesEventGoToHomeScreen>(
      (event, emit) {
        emit(
          NotesStateNoteOrTaskAdded(
            isLoading: false,
          ),
        );
      },
    );
    on<NotesEventDeleteTaskOrNotes>(
      (event, emit) async {
        emit(
          NotesStateNoteOrTaskAdded(
            isLoading: true,
          ),
        );
        await FirebaseFirestore.instance
            .collection('notes')
            .doc(event.id)
            .delete();
        return emit(
          NotesStateNoteOrTaskdDeleted(
            isLoading: false,
          ),
        );
      },
    );
    on<NotesEventGoToEditNotes>(
      (event, emit) {
        emit(
          NotesStateInEditScreen(
            notes: event.notes,
            isLoading: false,
          ),
        );
      },
    );
    on<NotesEventEditNotes>(
      (event, emit) async {
        // emit(
        //   NotesStateInEditScreen(
        //     isLoading: true,
        //   ),
        // );

        try {
          await homeRepository.editData(event.title, event.body, event.noteId);
          return emit(
            NotesStateNoteOrTaskAdded(
              isLoading: false,
            ),
          );
        } on Exception catch (e) {
          return emit(
            NotesStateInEditScreen(
              isLoading: false,
              noteError: NoteError.from(e),
            ),
          );
        }
      },
    );
  }
}
