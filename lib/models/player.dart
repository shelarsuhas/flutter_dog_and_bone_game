import '../utils/cell_type.dart';
import 'cell.dart';

class Player {
  Cell position;

  Player({required this.position}) {
    position.cellType = CellType.player;
  }

  void move(Cell nextCell) {
    position.cellType = CellType.empty;

    position = nextCell;
    position.cellType = CellType.player;
  }

  Cell getCurrentPosition() {
    return position;
  }
}
