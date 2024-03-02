import 'package:flutter/material.dart';

Map<String, NoteError> noteErrorMapping = {
  'no-internet': NoteErrorNoInternet(),
};

@immutable
abstract class NoteError {
  final String dialogTitle, dialogBody;

  NoteError({
    required this.dialogTitle,
    required this.dialogBody,
  });

  factory NoteError.from(Exception exception) =>
      noteErrorMapping[exception.toString().toLowerCase().trim()] ??
      NoteErrorUnknown();
}

@immutable
class NoteErrorNoInternet extends NoteError {
  NoteErrorNoInternet()
      : super(
          dialogTitle: "No internet",
          dialogBody: 'Please check your internet',
        );
}

@immutable
class NoteErrorUnknown extends NoteError {
  NoteErrorUnknown()
      : super(
          dialogTitle: 'Unknown Error',
          dialogBody: 'Unknown Error',
        );
}
