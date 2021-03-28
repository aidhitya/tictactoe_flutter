import 'package:flutter/material.dart';
import 'package:tictactoe/games/box_button.dart';
import 'package:tictactoe/games/tile_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dialogKey = GlobalKey<NavigatorState>();
  var _boardState = List.filled(9, TileState.EMPTY);
  var _currentTurn = TileState.CROSS;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: dialogKey,
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/board.png'),
                  _boardTile(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _boardTile() {
    return Builder(builder: (context) {
      final boardDimension = MediaQuery.of(context).size.width;
      final boxDimension = boardDimension / 3;

      return Container(
        width: boardDimension,
        height: boardDimension,
        child: Column(
          children: chunk(_boardState, 3).asMap().entries.map((i) {
            final bigChunkKey = i.key;
            final bigChunkValue = i.value;

            return Row(
              children: bigChunkValue.asMap().entries.map((e) {
                final smallChunkKey = e.key;
                final tileState = e.value;

                final realChunk = (bigChunkKey * 3) + smallChunkKey;

                return BoxButton(
                  dimension: boxDimension,
                  tileState: tileState,
                  onPressed: () => _updateTheTile(realChunk),
                );
              }).toList(),
            );
          }).toList(),
        ),
      );
    });
  }

  void _updateTheTile(int indexTile) {
    if (_boardState[indexTile] == TileState.EMPTY) {
      setState(() {
        _boardState[indexTile] = _currentTurn;

        _currentTurn = _currentTurn == TileState.CROSS
            ? TileState.CIRCLE
            : TileState.CROSS;
      });

      final winner = _findWinner();
      if (_findWinner() != null) {
        print('$winner');
        _alertWinnerModal(winner);
      }
    }
  }

  TileState _findWinner() {
    TileState Function(int, int, int) winnerForMatch = (a, b, c) {
      if (_boardState[a] != TileState.EMPTY) {
        if ((_boardState[a] == _boardState[b]) &&
            (_boardState[b] == _boardState[c])) {
          return _boardState[a];
        }
      }
      return null;
    };

    final winnerChecks = [
      winnerForMatch(0, 4, 8),
      winnerForMatch(2, 4, 6),
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
    ];

    final TileState winner = winnerChecks.firstWhere(
      (TileState element) => element != null,
      orElse: () => null,
    );

    return winner;
  }

  void _alertWinnerModal(TileState tileState) {
    final context = dialogKey.currentState.overlay.context;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: tileState == TileState.CROSS
                ? Text('CROSS is The Winner')
                : Text('CIRCLE is The Winnder'),
            content: tileState == TileState.CROSS
                ? Image.asset('assets/images/x.png')
                : Image.asset('assets/images/o.png'),
            actions: [
              TextButton(
                  onPressed: () {
                    _newGame();
                    Navigator.of(context).pop();
                  },
                  child: Text('New Game'))
            ],
          );
        });
  }

  void _newGame() {
    setState(() {
      _boardState = List.filled(9, TileState.EMPTY);
      _currentTurn = TileState.CROSS;
    });
  }
}
