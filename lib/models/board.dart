import 'package:flutter_dog_and_bone_game/models/cell.dart';
import 'dart:math' as math;

import 'package:flutter_dog_and_bone_game/utils/cell_type.dart';

class Board {
  final int rowCount, colCount;

  late List<List<Cell>> cells;

  Board(this.rowCount, this.colCount) {
    cells = List.empty();
    cells = List.generate(
        rowCount,
        (i) => List.generate(
              colCount,
              (j) {
                return Cell(row: i, col: j);
              },
            ),
        growable: false);
  }

  List<List<Cell>> getCells() {
    return cells;
  }

  void setCells(List<List<Cell>> cells) {
    this.cells = cells;
  }

  void generateToken() {
    int row = -1;
    int col = -1;
    while (true) {
      row = math.Random().nextInt(rowCount);
      col = math.Random().nextInt(colCount);

      if (cells[row][col].cellType != CellType.player) {
        break;
      }
    }

    cells[row][col].cellType = CellType.token;
  }

  Cell generateRandomStartPosition() {
    int row = -1;
    int col = -1;
    while (true) {
      row = math.Random().nextInt(rowCount);
      col = math.Random().nextInt(colCount);

      if (cells[row][col].cellType != CellType.token) {
        break;
      }
    }

    cells[row][col].cellType = CellType.player;
    return cells[row][col];
  }
}
