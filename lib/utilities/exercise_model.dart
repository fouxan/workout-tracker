import 'package:flutter/services.dart';
import 'dart:convert';

class Exercise {
  final String name;
  final String equipment;
  final String gifUrl;
  final String bodyPart;
  final String target;
  final String id;

  Exercise({
    required this.name,
    required this.equipment,
    required this.gifUrl,
    required this.bodyPart,
    required this.target,
    required this.id,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json["name"],
      equipment: json["equipment"],
      gifUrl: json["gifUrl"],
      bodyPart: json["bodyPart"],
      target: json["target"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'equipment': equipment,
      'gifUrl': gifUrl,
      'bodyPart': bodyPart,
      'target': target,
      'id': id,
    };
  }
}

Future<List<Exercise>> loadExercises() async {
  final jsonStr = await rootBundle.loadString('assets/exercises.json');
  final jsonList = json.decode(jsonStr) as List<dynamic>;
  return jsonList.map((json) => Exercise.fromJson(json)).toList();
}
