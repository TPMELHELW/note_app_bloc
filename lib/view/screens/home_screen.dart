import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:note_app_bloc/bloc/notes/notes_bloc.dart';
import 'package:note_app_bloc/view/screens/note_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTabController(initialLength: 4);
    final selectedIndex = useState(0); // Mutable state for the selected index
    List<IconData> icon = [
      Ionicons.reader_outline,
      Ionicons.checkmark_done_outline,
      Ionicons.person_outline,
      Ionicons.settings_outline,
    ];

    // Update the controller index when the state changes
    useEffect(() {
      controller.index = selectedIndex.value;
      return () {};
    }, [selectedIndex.value]);

    return Scaffold(
      floatingActionButton: selectedIndex.value == 0 || selectedIndex.value == 1
          ? FloatingActionButton(
              onPressed: () {
                context.read<NotesBloc>().add(
                      NotesEventGoToAddNoteOrTask(),
                    );
              },
              child: const Icon(
                Icons.add,
              ),
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TabBar(
                isScrollable: false,
                onTap: (index) {
                  selectedIndex.value = index;
                },
                splashBorderRadius: BorderRadius.circular(30),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                controller: controller,
                tabs: List.generate(
                  icon.length,
                  (index) {
                    return Tab(
                      icon: Icon(icon[index]),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          TaskOrNoteScreen(
            type: 'Note',
          ),
          TaskOrNoteScreen(
            type: 'Task',
          ),
          Center(
            child: Text('test 2'),
          ),
          Center(
            child: Text('test 3'),
          ),
        ],
      ),
    );
  }
}
