part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

@immutable
class NotesEventGoToAddNoteOrTask extends NotesEvent {}

@immutable
class NotesEventGoToHomeScreen extends NotesEvent {}

@immutable
class NotesEventAddNoteOrTask extends NotesEvent {
  final String title, body, selected;

  NotesEventAddNoteOrTask(this.selected,
      {required this.title, required this.body});
}

@immutable
class NotesEventDeleteTaskOrNotes extends NotesEvent {
  final String id;
  NotesEventDeleteTaskOrNotes({required this.id});
}

@immutable
class NotesEventGoToEditNotes extends NotesEvent {
  final notes;
  NotesEventGoToEditNotes({required this.notes});
}

@immutable
class NotesEventEditNotes extends NotesEvent {
  final String noteId, title, body;

  NotesEventEditNotes(
      {required this.noteId, required this.title, required this.body});
}
