import '../utils/cell_type.dart';

class Cell {
  final int row;
  final int col;
  CellType cellType = CellType.empty;

  Cell({required this.row, required this.col});

  CellType getCellType() {
    return cellType;
  }

  int getRow() {
    return row;
  }

  int getCol() {
    return col;
  }
}
