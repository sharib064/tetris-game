import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/value.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  int currentScore = 0;

  Piece currPiece = Piece(type: Tetromino.L);
  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currPiece.initializePiece();
    const Duration timeframe = Duration(milliseconds: 800);
    gameLoop(timeframe);
  }

  void gameLoop(Duration timeframe) {
    Timer.periodic(timeframe, (timer) {
      setState(() {
        clearLines();
        checkLanding();
        if (gameOver) {
          timer.cancel();
          showGameOverDialog();
        }
        currPiece.moveBox(Direction.down);
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          "Game Over",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
        content: Text(
          "Your score is:  $currentScore",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: const Text(
              "Resart game",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLenght,
        (j) => null,
      ),
    );
    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currPiece.positions.length; i++) {
      int row = (currPiece.positions[i] / rowLenght).floor();
      int col = currPiece.positions[i] % rowLenght;
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }
      if (row >= colLength ||
          col < 0 ||
          col >= rowLenght ||
          (row >= 0 && col >= 0 && gameBoard[row][col] != null)) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currPiece.positions.length; i++) {
        int row = (currPiece.positions[i] / rowLenght).floor();
        int col = currPiece.positions[i] % rowLenght;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currPiece.type;
        }
      }
      createNewPiece();
    }
  }

  bool gameOver = false;

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currPiece = Piece(type: randomType);
    currPiece.initializePiece();
    if (isGameOver()) {
      gameOver = true;
    }
  }

  bool isGameOver() {
    for (int i = 0; i < rowLenght; i++) {
      if (gameBoard[0][i] != null) {
        return true;
      }
    }
    return false;
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLenght; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(
          row,
          (index) => null,
        );
        currentScore++;
      }
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currPiece.moveBox(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currPiece.moveBox(Direction.right);
      });
    }
  }

  void moveRotate() {
    setState(() {
      currPiece.rotateBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLenght * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLenght),
              itemBuilder: (context, index) {
                int row = (index / rowLenght).floor();
                int col = index % rowLenght;
                if (currPiece.positions.contains(index)) {
                  return Pixel(color: currPiece.color);
                } else if (gameBoard[row][col] != null) {
                  final Tetromino? tetraminoType = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColor[tetraminoType],
                  );
                } else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                "Score:$currentScore",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: moveRotate,
                    color: Colors.white,
                    icon: const Icon(Icons.rotate_90_degrees_cw)),
                IconButton(
                    onPressed: moveRight,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_forward_ios))
              ],
            ),
          )
        ],
      ),
    );
  }
}
