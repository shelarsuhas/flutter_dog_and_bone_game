import 'package:flutter/material.dart';
import 'package:flutter_dog_and_bone_game/models/cell.dart';
import 'package:flutter_dog_and_bone_game/utils/cell_type.dart';
import 'package:flutter_dog_and_bone_game/utils/swipe_direction.dart';
import 'package:stacked/stacked.dart';

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
                    model.onSwipe(SwipeDirection.down);
                  } else {
                    model.onSwipe(SwipeDirection.up);
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    model.onSwipe(SwipeDirection.right);
                  } else {
                    model.onSwipe(SwipeDirection.left);
                  }
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
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Score: 2",
                      style: TextStyle(
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
