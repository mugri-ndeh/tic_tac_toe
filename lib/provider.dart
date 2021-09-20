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

  updateTile(int index) {
    if (clickedTiles.isEmpty || !clickedTiles.contains(index)) {
      if (currentPlayer == player1) {
        clickedTiles.add(index);
        p1Tiles.add(index);
        tiles[index] = player1;
        checkWinner('player1', p1Tiles);
        currentPlayer = player2;
        notifyListeners();
      } else {
        clickedTiles.add(index);
        p2Tiles.add(index);
        tiles[index] = player2;
        checkWinner('player2', p2Tiles);
        currentPlayer = player1;
        notifyListeners();
      }
    }
  }

  checkWinner(String player, List list) {
    if (list.contains(0)) {
      if (list.contains(3) && list.contains(6)) {
        winner = true;
        endgame(player, winner);
      } else if (list.contains(1) && list.contains(2)) {
        winner = true;
        endgame(player, winner);
      } else if (list.contains(4) && list.contains(8)) {
        winner = true;
        endgame(player, winner);
      }
    } else if (list.contains(6)) {
      if (list.contains(7) && list.contains(8)) {
        winner = true;
        endgame(player, winner);
      } else if (list.contains(4) && list.contains(2)) {
        winner = true;
        endgame(player, winner);
      }
    } else if (list.contains(2) && list.contains(5) && list.contains(8)) {
      winner = true;
      endgame(player, winner);
    }
    if (clickedTiles.length == tiles.length && winner == false) {
      print('ended');
      endgame(player, false);
    }
  }

  endgame(String player, bool winner) {
    if (winner == true) {
      print('$player has won the game');
    } else {
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
