import 'package:flutter/material.dart';

int rowLenght = 10;
int colLength = 15;

enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

enum Direction {
  left,
  right,
  down,
}

Map<Tetromino, Color> tetrominoColor = {
  Tetromino.I: Colors.orange,
  Tetromino.J: Colors.blue,
  Tetromino.L: Colors.pink,
  Tetromino.O: Colors.yellow,
  Tetromino.S: Colors.green,
  Tetromino.T: Colors.red,
  Tetromino.Z: Colors.purple,
};
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLenght,
    (j) => null,
  ),
);
