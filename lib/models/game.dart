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

        if (nextCell.cellType == CellType.token) {
          score++;
          if (score == 10) {
            isGameOver = true;
          } else {
            board.generateToken();
          }
        }

        player.move(nextCell);
      }
    }
  }

  Cell getNextCell(Cell currentPosition, SwipeDirection direction) {
    int row = currentPosition.row;
    int col = currentPosition.col;

    if (direction == SwipeDirection.right) {
      row++;
    } else if (direction == SwipeDirection.left) {
      row--;
    } else if (direction == SwipeDirection.up) {
      col--;
    } else if (direction == SwipeDirection.down) {
      col++;
    }

    if (row < 0) {
      row = board.rowCount - 1;
    }
    if (row >= board.rowCount) {
      row = 0;
    }

    if (col < 0) {
      col = board.colCount - 1;
    }
    if (col >= board.colCount) {
      col = 0;
    }

    return board.getCells()[row][col];
  }
}
