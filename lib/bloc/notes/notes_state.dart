part of 'notes_bloc.dart';

@immutable
sealed class NotesState {
  final bool isLoading;
  final NoteError? noteError;

  NotesState({
    required this.isLoading,
    this.noteError,
  });
}

final class NotesInitial extends NotesState {
  NotesInitial({
    required super.isLoading,
    super.noteError,
  });
}

// @immutable
// class NotesStateInAddNotes extends NotesState {
//   NotesStateInAddNotes({
//     required super.isLoading,
//     super.noteError,
//   });
// }

@immutable
class NotesStateInAddTaskOrNotes extends NotesState {
  NotesStateInAddTaskOrNotes({
    required super.isLoading,
    super.noteError,
  });
}

@immutable
class NotesStateInEditScreen extends NotesState {
  final notes;
  NotesStateInEditScreen(
      {required super.isLoading, this.notes, super.noteError});
}

@immutable
class NotesStateNoteOrTaskAdded extends NotesState {
  NotesStateNoteOrTaskAdded({
    required super.isLoading,
  });
}

@immutable
class NotesStateNoteOrTaskdDeleted extends NotesState {
  NotesStateNoteOrTaskdDeleted({required super.isLoading});
}
