import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicTacGame with ChangeNotifier {
  void init() {
    currentPlayer = player1;
    for (int i = 0; i < 9; i++) {
      tiles.add('');
    }
  }

  String player1 = 'X';
  String player2 = 'O';
  String tapText = '';
  List p1Tiles = [];
  List p2Tiles = [];
  List tiles = [];
  String currentPlayer = '';
  List<int> clickedTiles = [];
  bool winner = false;

  updateTile(int index, BuildContext context) {
    if (clickedTiles.isEmpty || !clickedTiles.contains(index)) {
      if (currentPlayer == player1) {
        clickedTiles.add(index);
        p1Tiles.add(index);
        tiles[index] = player1;
        checkWinner('player1', p1Tiles, context);
        currentPlayer = player2;
        notifyListeners();
      } else {
        clickedTiles.add(index);
        p2Tiles.add(index);
        tiles[index] = player2;
        checkWinner('player2', p2Tiles, context);
        currentPlayer = player1;
        notifyListeners();
      }
    }
  }

  checkWinner(String player, List list, BuildContext context) {
    if (list.contains(0)) {
      if (list.contains(3) && list.contains(6)) {
        winner = true;
        endgame(player, winner, context);
      } else if (list.contains(1) && list.contains(2)) {
        winner = true;
        endgame(player, winner, context);
      } else if (list.contains(4) && list.contains(8)) {
        winner = true;
        endgame(player, winner, context);
      }
    } else if (list.contains(6)) {
      if (list.contains(7) && list.contains(8)) {
        winner = true;
        endgame(player, winner, context);
      } else if (list.contains(4) && list.contains(2)) {
        winner = true;
        endgame(player, winner, context);
      }
    } else if (list.contains(4)) {
      if (list.contains(1) && list.contains(7)) {
        winner = true;
        endgame(player, winner, context);
      } else if (list.contains(3) && list.contains(5)) {
        winner = true;
        endgame(player, winner, context);
      }
    } else if (list.contains(2) && list.contains(5) && list.contains(8)) {
      winner = true;
      endgame(player, winner, context);
    }
    if (clickedTiles.length == tiles.length && winner == false) {
      print('ended');
      endgame(player, false, context);
    }
  }

  endgame(String player, bool winner, BuildContext context) {
    if (winner == true) {
      print('$player has won the game');
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        body: Center(
          child: Text(
            '$player has won the game',
            style: TextStyle(fontStyle: FontStyle.normal),
          ),
        ),
        title: 'This is Ignored',
        desc: 'This is also Ignored',
        btnOkOnPress: () {},
      )..show();
      Future.delayed(Duration(seconds: 1), () {
        reset();
      });
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        body: Center(
          child: Text(
            'Draw',
            style: TextStyle(fontStyle: FontStyle.normal),
          ),
        ),
        title: 'This is Ignored',
        desc: 'This is also Ignored',
        btnOkOnPress: () {},
      )..show();
      Future.delayed(Duration(seconds: 1), () {
        reset();
      });
      print('Draw');
    }
  }

  void reset() {
    winner = false;
    p1Tiles = [];
    p2Tiles = [];
    clickedTiles = [];
    tiles = [];
    init();
    notifyListeners();
  }
}
