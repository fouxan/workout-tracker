import 'package:flutter/material.dart';
import 'package:workout_tracker/utilities/exercise_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});
  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  late Future<List<Exercise>> exercises;
  List<String> sortOptions = ['Alphabetically', 'By Body Part'];
  String selectedSortOption = 'By Body Part';
  Map<String, List<Exercise>> exercisesByBodyPart = {};
  TextEditingController searchController = TextEditingController();
  List<Exercise> searchResults = [];

  @override
  void initState() {
    super.initState();
    exercises = loadExercises();
    searchResults = [];
  }

  String toTitleCase(String input) {
    if (input.isEmpty) {
      return input;
    }

    final List<String> words = input.toLowerCase().split(' ');
    final List<String> capitalizedWords = words.map((word) {
      final String firstLetter = word.substring(0, 1).toUpperCase();
      final String remainingLetters = word.substring(1);
      return '$firstLetter$remainingLetters';
    }).toList();

    return capitalizedWords.join(' ');
  }

  void searchExercises() {
    final searchTerm = searchController.text.toLowerCase();
    if (searchTerm.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    exercises.then((exerciseList) {
      setState(() {
        searchResults = exerciseList.where((exercise) {
          return exercise.name.toLowerCase().contains(searchTerm);
        }).toList();
      });
    });
  }

  Map<String, List<Exercise>> groupExercisesByBodyPart(
      List<Exercise> exercises) {
    final groupedExercises = <String, List<Exercise>>{};
    for (final exercise in exercises) {
      final bodyPart = exercise.bodyPart;
      if (groupedExercises.containsKey(bodyPart)) {
        groupedExercises[bodyPart]!.add(exercise);
      } else {
        groupedExercises[bodyPart] = [exercise];
      }
    }
    return groupedExercises;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Exercise',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchExercises,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Exercise>>(
              future: exercises,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text('No exercises found.'),
                  );
                } else {
                  final exercises = snapshot.data!;
                  if (searchController.text.isEmpty) {
                    return ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        return ListTile(
                          title: Text(toTitleCase(exercise.name)),
                          subtitle: Text(toTitleCase(exercise.target)),
                          leading: CachedNetworkImage(
                            imageUrl: exercise.gifUrl,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_rounded)),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final exercise = searchResults[index];
                        return ListTile(
                          title: Text(toTitleCase(exercise.name)),
                          subtitle: Text(toTitleCase(exercise.target)),
                          leading: CachedNetworkImage(
                            imageUrl: exercise.gifUrl,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_rounded)),
                        );
                      },
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
