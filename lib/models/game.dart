import 'package:flutter_dog_and_bone_game/models/cell.dart';
import 'package:flutter_dog_and_bone_game/models/player.dart';
import 'package:flutter_dog_and_bone_game/utils/cell_type.dart';
import 'package:flutter_dog_and_bone_game/utils/swipe_direction.dart';

import 'board.dart';

class Game {
  late Player player;
  late Board board;
  SwipeDirection direction = SwipeDirection.none;
  int score = 0;
  bool isGameOver = false;

  Game({required int row, required int col}) {
    board = Board(row, col);
    player = Player(position: board.generateRandomStartPosition());
    board.generateToken();
  }

  void onUserSwipe(SwipeDirection direction) {
    if (!isGameOver) {
      if (direction != SwipeDirection.none) {
        Cell nextCell = getNextCell(player.getCurrentPosition(), direction);

        player.move(nextCell);
        if (nextCell.cellType == CellType.token) {
          score++;
          if (score == 10) {
            isGameOver = true;
          } else {
            board.generateToken();
          }
        }
      }
    }
  }

  Cell getNextCell(Cell currentPosition, SwipeDirection direction) {
    int row = currentPosition.row;
    int col = currentPosition.col;

    if (direction == SwipeDirection.right) {
      col++;
    } else if (direction == SwipeDirection.left) {
      col--;
    } else if (direction == SwipeDirection.up) {
      row--;
    } else if (direction == SwipeDirection.left) {
      row++;
    }

    // if (row < 0) {
    //   row = board.rowCount;
    // }
    // if (row > board.rowCount) {
    //   row = 0;
    // }

    // if (col < 0) {
    //   col = board.colCount;
    // }
    // if (col > board.colCount) {
    //   col = 0;
    // }

    return board.getCells()[row][col];
  }
}
