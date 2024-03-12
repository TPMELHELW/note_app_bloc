import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_bloc/core/constant/color.dart';

class TaskViewWidget extends StatelessWidget {
  final List notes;
  const TaskViewWidget({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      itemCount: notes.length,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        // final notes = notes.data!;
        return Dismissible(
          onDismissed: (val) {},
          key: Key('4'),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: tileColors[index % 7],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "${notes[index]['title']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25, fontFamily: 'tajawal'),
                  ),
                  Text(
                    "${notes[index]['time']}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
