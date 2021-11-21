import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/service_locator.dart';
import '../../../../models/cell.dart';
import '../../../../models/game.dart';
import '../../../../utils/swipe_direction.dart';

class GameViewModel extends BaseViewModel {
  int row = 5;
  int col = 10;
  DialogService dialogService = locator<DialogService>();

  SwipeDirection direction = SwipeDirection.none;

  late Game game;

  GameViewModel() {
    dialogService = DialogService();
  }

  void newGame() {
    game = Game(row: row, col: col);
    notifyListeners();
  }

  void onSwipe() {
    game.onUserSwipe(direction);
    notifyListeners();
    checkEndGame();
  }

  void checkEndGame() {
    if (game.isGameOver) {
      showRestartDialog();
    }
  }

  void showRestartDialog() async {
    DialogResponse? response = await dialogService.showDialog(
        title: "Winner Winner Chicken Dinner",
        description: "Play again?",
        buttonTitle: "Yes",
        cancelTitle: "No");

    if (response != null && response.confirmed) {
      game.restartGame();
      notifyListeners();
    } else {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else {
        exit(0);
      }
    }
  }

  Cell getCurrentPosition() {
    return game.player.position;
  }

  List<List<Cell>> getBoard() {
    return game.board.cells;
  }

  void restartGame() {
    game.restartGame();
    notifyListeners();
  }
}
