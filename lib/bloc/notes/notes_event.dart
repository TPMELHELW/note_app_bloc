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
