import 'dart:async';
import 'dart:io';
import 'dart:convert';

class Vector2 {
  int x = 0;
  int y = 0;

  Vector2(int x, int y) {
    this.x = x;
    this.y = y;
  }

  Vector2 sum(Vector2 vector) {
    return Vector2(this.x + vector.x, this.y + vector.y);
  }

  String toString() {
    return '[x: ${x}, y: ${y}]';
  }

  int magnitude() {
    return x * y;
  }
}

Future<String> readFromFile(String name) async {
  File file = new File('input.txt');
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
    vector = vector.sum(localVector);
  }
  return vector;
}

void main() async {
	String contents = await readFromFile("input.txt");
  List<String> separatedContents = contents.split('\n');
  List<Vector2> vectors = await convertToVectors(separatedContents);
  Vector2 vector = await sumVectors(vectors);
  print('Depth is: ${vector.magnitude()}');
}
