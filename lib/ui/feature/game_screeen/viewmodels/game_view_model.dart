import 'package:stacked/stacked.dart';

import '../../../../models/cell.dart';
import '../../../../models/game.dart';
import '../../../../utils/swipe_direction.dart';

class GameViewModel extends BaseViewModel {
  int row = 20;
  int col = 40;

  late Game game;

  void newGame() {
    game = Game(row: row, col: col);
    notifyListeners();
  }

  void onSwipe(SwipeDirection direction) {
    game.onUserSwipe(direction);
    print(direction);
    notifyListeners();
  }

  Cell getCurrentPosition() {
    return game.player.position;
  }

  List<List<Cell>> getBoard() {
    return game.board.cells;
  }
}
