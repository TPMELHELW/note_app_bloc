import 'package:bloc/bloc.dart';
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
    on<NotesEventGoToHomeScreen>((event, emit) {
      emit(
        NotesStateNoteOrTaskAdded(
          isLoading: false,
        ),
      );
    });
  }
}
