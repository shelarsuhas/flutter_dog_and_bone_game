import 'package:stacked/stacked.dart';

import '../../../../models/cell.dart';
import '../../../../models/game.dart';
import '../../../../utils/swipe_direction.dart';

class GameViewModel extends BaseViewModel {
  int row = 10;
  int col = 20;

  SwipeDirection direction = SwipeDirection.none;

  late Game game;

  void newGame() {
    game = Game(row: row, col: col);
    notifyListeners();
  }

  void onSwipe() {
    game.onUserSwipe(direction);
    notifyListeners();
  }

  Cell getCurrentPosition() {
    return game.player.position;
  }

  List<List<Cell>> getBoard() {
    return game.board.cells;
  }
}
