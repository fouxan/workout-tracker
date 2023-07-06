// import 'package:workout_tracker/utilities/exercise_model.dart';

// import 'package:firebase/firebase.dart' as firebase;

// class Routine {
//   String name;
//   List<Exercise> exercises;
//   int numberOfExercises;

//   Routine({required this.name, required this.exercises}) {
//     numberOfExercises = exercises.length;
//   }

//   void addToRoutine(Exercise exercise) {
//     exercises.add(exercise);
//     numberOfExercises++;
//     updateRoutineInFirebase();
//   }

//   void deleteExercise(Exercise exercise) {
//     exercises.remove(exercise);
//     numberOfExercises--;
//     updateRoutineInFirebase();
//   }

//   void deleteRoutine() {
//     // Delete the routine from the Firebase Cloud Database
//     // Replace 'your-firebase-database-path' with your actual Firebase database path
//     firebase.database().ref('your-firebase-database-path/${name}').remove();
//   }

//   void updateRoutineInFirebase() {
//     // Update the routine in the Firebase Cloud Database
//     // Replace 'your-firebase-database-path' with your actual Firebase database path
//     firebase.database().ref('your-firebase-database-path/${name}').set(toJson());
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
//       'numberOfExercises': numberOfExercises,
//     };
//   }

//   factory Routine.fromJson(Map<String, dynamic> json) {
//     return Routine(
//       name: json['name'],
//       exercises: (json['exercises'] as List<dynamic>)
//           .map((exerciseJson) => Exercise.fromJson(exerciseJson))
//           .toList(),
//     );
//   }
// }
