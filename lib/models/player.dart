import 'package:flutter_dog_and_bone_game/models/cell.dart';
import 'package:flutter_dog_and_bone_game/utils/cell_type.dart';

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
