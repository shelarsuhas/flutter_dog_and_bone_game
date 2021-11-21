import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../models/cell.dart';
import '../../../../utils/cell_type.dart';
import '../../../../utils/game_constants.dart';
import '../../../../utils/swipe_direction.dart';
import '../viewmodels/game_view_model.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GameViewModel>.reactive(
      viewModelBuilder: () => GameViewModel(),
      onModelReady: (model) => model.newGame(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0) {
                    model.direction = SwipeDirection.down;
                  } else {
                    model.direction = SwipeDirection.up;
                  }
                },
                onVerticalDragEnd: (detail) {
                  model.onSwipe();
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    model.direction = SwipeDirection.right;
                  } else {
                    model.direction = SwipeDirection.left;
                  }
                },
                onHorizontalDragEnd: (details) {
                  model.onSwipe();
                },
                child: AspectRatio(
                  aspectRatio: model.row / (model.col + 5),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: model.row,
                    ),
                    itemCount: model.row * model.col,
                    itemBuilder: (BuildContext context, int index) {
                      var x = index % model.row;
                      var y = (index / model.row).floor();

                      var color;

                      List<List<Cell>> board = model.getBoard();

                      if (board[x][y].cellType == CellType.player) {
                        color = Colors.blue;
                      } else if (board[x][y].cellType == CellType.token) {
                        color = Colors.red;
                      } else {
                        color = Colors.grey.shade500;
                      }

                      return Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      model.game.score >= kMaxScore
                          ? "WINNER!!"
                          : "Score: ${model.game.score}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
