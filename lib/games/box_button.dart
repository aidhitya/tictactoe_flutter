import 'package:flutter/material.dart';
import 'package:tictactoe/games/tile_player.dart';

class BoxButton extends StatelessWidget {
  final double dimension;
  final VoidCallback onPressed;
  final TileState tileState;

  const BoxButton({Key key, this.tileState, this.dimension, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimension,
      width: dimension,
      child: TextButton(
        // style: TextButton.styleFrom(shadowColor: Colors.red),
        onPressed: onPressed,
        child: _tileStateCondition(),
      ),
    );
  }

  Widget _tileStateCondition() {
    Widget widget;

    switch (tileState) {
      case TileState.EMPTY:
        widget = Container();

        break;

      case TileState.CROSS:
        widget = Image.asset('assets/images/x.png');

        break;

      case TileState.CIRCLE:
        widget = Image.asset('assets/images/o.png');

        break;
    }

    return widget;
  }
}
