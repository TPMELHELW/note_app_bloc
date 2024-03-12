// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:group_button/group_button.dart';
import 'package:note_app_bloc/bloc/notes/notes_bloc.dart';
import 'package:note_app_bloc/view/widgets/custom_button_widget.dart';
import 'package:note_app_bloc/view/widgets/custom_field_widget.dart';

class AddScreen extends HookWidget {
  final bool isEdit;
  final QueryDocumentSnapshot<Map<String, dynamic>>? note;
  const AddScreen({
    super.key,
    this.note,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = useTextEditingController();
    TextEditingController bodyController = useTextEditingController();

    if (isEdit) {
      titleController.text = note!['title'];
      bodyController.text = note!['body'];
    }
    String selected = 'Task';
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButtonWidget(
                  onPress: () {
                    context.read<NotesBloc>().add(
                          NotesEventGoToHomeScreen(),
                        );
                  },
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                CustomButtonWidget(
                  onPress: () {
                    isEdit
                        ? context.read<NotesBloc>().add(
                              NotesEventEditNotes(
                                noteId: note!.id,
                                title: titleController.text,
                                body: bodyController.text,
                              ),
                            )
                        : context.read<NotesBloc>().add(
                              NotesEventAddNoteOrTask(
                                selected,
                                title: titleController.text,
                                body: bodyController.text,
                              ),
                            );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            GroupButton(
              isRadio: true,
              onSelected: (value, index, isSelected) => selected = value,
              buttons: const [
                'Task',
                'Note',
              ],
            ),
            Form(
              child: Column(
                children: [
                  CustomFieldWidget(
                    controller: titleController,
                    hint: 'Note title...',
                  ),
                  CustomFieldWidget(
                    controller: bodyController,
                    hint: 'Note body...',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
