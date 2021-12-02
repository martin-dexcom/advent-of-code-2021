import 'dart:async';
import 'dart:io';
import 'dart:convert';

class Vector2 {
  int x = 0;
  int y = 0;
  int depth = 0;

  Vector2(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void sum(Vector2 vector) {
    // Increases horizontal position
    this.x += vector.x;
    // Increases vertical position
    this.y += vector.y;
    // Sum to depth
    this.depth += this.y * vector.x;
  }

  String toString() {
    return '[x: ${x}, y: ${y}]';
  }

  int magnitude() {
    return x * y;
  }

  int calculatedDepth() {
    return this.depth * this.x;
  }
}

Future<String> readFromFile(String name) async {
  File file = new File(name);
  Future<String> futureContent = file.readAsString();
  return futureContent;
}

Future<List<Vector2>> convertToVectors(List<String> elements) async {
  List<Vector2> vectors = [];
  for(var element in elements) {
    List<String> directionForce = element.split(' ');
    switch (directionForce[0]) {
      case 'up':
        vectors.add(Vector2(0,-int.parse(directionForce[1])));
        break;
      case 'down':
        vectors.add(Vector2(0,int.parse(directionForce[1])));
        break;
      case 'forward':
        vectors.add(Vector2(int.parse(directionForce[1]),0));
        break;
    }
  }
  return vectors;
}

Future<Vector2> sumVectors(List<Vector2> vectors) async {
  Vector2 vector = new Vector2(0,0);
  for (var localVector in vectors) {
    vector.sum(localVector);
  }
  return vector;
}

void main() async {
  // Get contents from  file
	String contents = await readFromFile("input.txt");
  // Convert them into usable chunks
  List<String> separatedContents = contents.split('\n');
  // Convert them into Vector2 instances
  List<Vector2> vectors = await convertToVectors(separatedContents);
  // Sum them all together (should be a reduce)
  Vector2 vector = await sumVectors(vectors);
  // Output results
  print('Magnitude is: ${vector.magnitude()}');
  print('Aim is: ${vector.y}');
  print('Depth is: ${vector.calculatedDepth()}');
}
