import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_bloc/core/constant/color.dart';
import 'package:note_app_bloc/core/repo/home_repository.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeRepository homeRepository = HomeRepository();
    return FutureBuilder(
      future: homeRepository.getNotes('Task'),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return MasonryGridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              final notes = snapshot.data!;
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
                          style: const TextStyle(
                              fontSize: 25, fontFamily: 'tajawal'),
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

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
