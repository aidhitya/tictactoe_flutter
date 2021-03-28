import 'package:flutter/material.dart';
import 'package:tictactoe/games/box_button.dart';
import 'package:tictactoe/games/tile_player.dart';

class BoardTiles extends StatelessWidget {
  const BoardTiles({Key key, this.onPressed, this.tileState}) : super(key: key);
  final VoidCallback onPressed;
  final TileState tileState;

  @override
  Widget build(BuildContext context) {
    final boardDimension = MediaQuery.of(context).size.width;
    final boxDimension = boardDimension / 3;

    return Container(
      width: boardDimension,
      height: boardDimension,
      child: Column(
        children: [
          Row(
            children: [
              BoxButton(
                onPressed: onPressed,
                dimension: boxDimension,
                tileState: tileState,
              )
            ],
          )
        ],
      ),
    );
  }
}
