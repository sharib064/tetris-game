import 'package:flutter/material.dart';
import 'package:tetris/value.dart';

class Piece {
  Tetromino type;
  Piece({required this.type});
  List<int> positions = [];
  Color get color {
    return tetrominoColor[type] ?? Colors.white;
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        positions = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        positions = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        positions = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        positions = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        positions = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        positions = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        positions = [
          -26,
          -15,
          -16,
          -6,
        ];
        break;
      default:
    }
  }

  void moveBox(Direction direction) {
    switch (direction) {
      case Direction.left:
        for (int i = 0; i < positions.length; i++) {
          positions[i] -= 1;
        }

        break;
      case Direction.right:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += 1;
        }

        break;
      case Direction.down:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += rowLenght;
        }

        break;
    }
  }

  int rotationState = 1;
  void rotateBox() {
    List<int> newPositions = [];
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPositions = [
              positions[1] - rowLenght,
              positions[1],
              positions[1] + rowLenght,
              positions[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPositions = [
              positions[1] + rowLenght,
              positions[1],
              positions[1] - rowLenght,
              positions[1] - rowLenght - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPositions = [
              positions[1] - rowLenght + 1,
              positions[1],
              positions[1] + 1,
              positions[1] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPositions = [
              positions[1] - rowLenght,
              positions[1],
              positions[1] + rowLenght,
              positions[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPositions = [
              positions[1] - rowLenght - 1,
              positions[1],
              positions[1] - 1,
              positions[1] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPositions = [
              positions[1] + rowLenght,
              positions[1],
              positions[1] - rowLenght,
              positions[1] - rowLenght + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPositions = [
              positions[1] + 1,
              positions[1],
              positions[1] - 1,
              positions[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + 2,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPositions = [
              positions[1] - rowLenght,
              positions[1],
              positions[1] + rowLenght,
              positions[1] + 2 * rowLenght,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPositions = [
              positions[1] + 1,
              positions[1],
              positions[1] - 1,
              positions[1] - 2,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPositions = [
              positions[1] + rowLenght,
              positions[1],
              positions[1] - rowLenght,
              positions[1] - 2 * rowLenght,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPositions = [
              positions[1],
              positions[1] + 1,
              positions[1] + rowLenght - 1,
              positions[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPositions = [
              positions[1] - rowLenght,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPositions = [
              positions[1],
              positions[1] + 1,
              positions[1] + rowLenght - 1,
              positions[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPositions = [
              positions[1] - rowLenght,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPositions = [
              positions[1] + rowLenght - 2,
              positions[1],
              positions[1] + rowLenght - 1,
              positions[1] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPositions = [
              positions[1] - rowLenght + 2,
              positions[1],
              positions[1] - rowLenght + 1,
              positions[1] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPositions = [
              positions[1] + rowLenght - 2,
              positions[1],
              positions[1] + rowLenght - 1,
              positions[1] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPositions = [
              positions[1] - rowLenght + 2,
              positions[1],
              positions[1] - rowLenght + 1,
              positions[1] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPositions = [
              positions[1] - rowLenght,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPositions = [
              positions[1] - rowLenght,
              positions[1] - 1,
              positions[1],
              positions[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPositions = [
              positions[1] - rowLenght,
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  bool positionIsValid(int position) {
    int row = (position / rowLenght).floor();
    int col = position % rowLenght;
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }
      int col = pos % rowLenght;
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLenght - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
