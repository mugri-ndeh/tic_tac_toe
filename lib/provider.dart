import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicTacGame with ChangeNotifier {
  void init() {
    //start with player 1
    currentPlayer = player1;
    //initialize tile list to empty strings
    for (int i = 0; i < 9; i++) {
      tiles.add('');
    }
  }

//player 1 and 2 symbols
  String player1 = 'X';
  String player2 = 'O';

//used to keep track of tiles clicked by each player
  List p1Tiles = [];
  List p2Tiles = [];

  //tiles on screen to be clicked
  List tiles = [];
  String currentPlayer = '';
  //used to keep track of selected tiles
  List<int> clickedTiles = [];
  //used to check if there was a winner or a draw
  bool winner = false;

  updateTile(int index, BuildContext context) {
    //update tiles only if the board is empty or tile has not been selected
    if (clickedTiles.isEmpty || !clickedTiles.contains(index)) {
      //player 1 plays
      if (currentPlayer == player1) {
        //fill the clicked tile
        clickedTiles.add(index);
        //tile index to user array to check  if use wins
        p1Tiles.add(index);
        tiles[index] = player1;
        checkWinner('player1', p1Tiles, context);
        currentPlayer = player2;
        notifyListeners();
      }
      //player 2 plays
      else {
        //fill the clicked tile
        clickedTiles.add(index);
        //tile index to user array to check  if use wins
        p2Tiles.add(index);
        tiles[index] = player2;
        checkWinner('player2', p2Tiles, context);
        currentPlayer = player1;
        notifyListeners();
      }
    }
  }

  //checking combinations
  checkWinner(String player, List list, BuildContext context) {
    if (list.contains(0)) {
      //leftward column
      if (list.contains(3) && list.contains(6)) {
        winner = true;
        endgame(player, winner, context);
      }
      //top row
      else if (list.contains(1) && list.contains(2)) {
        winner = true;
        endgame(player, winner, context);
      }
      //diagonal
      else if (list.contains(4) && list.contains(8)) {
        winner = true;
        endgame(player, winner, context);
      }
      //6 can  take leftward column and diagonal
    } else if (list.contains(6)) {
      //bottom row
      if (list.contains(7) && list.contains(8)) {
        winner = true;
        endgame(player, winner, context);
      }
      //diagonal
      else if (list.contains(4) && list.contains(2)) {
        winner = true;
        endgame(player, winner, context);
      }
    } //taking 4 at the center of 3x3 grid
    else if (list.contains(4)) {
      //middle vertical
      if (list.contains(1) && list.contains(7)) {
        winner = true;
        endgame(player, winner, context);
      }
      //middle horizontal
      else if (list.contains(3) && list.contains(5)) {
        winner = true;
        endgame(player, winner, context);
      }
    }
    //right most column
    else if (list.contains(2) && list.contains(5) && list.contains(8)) {
      winner = true;
      endgame(player, winner, context);
    }
    //if all tiles of board are selected with no winner
    if (clickedTiles.length == tiles.length && winner == false) {
      print('ended');
      endgame(player, false, context);
    }
  }

//endgame in casee of draw or win
  endgame(String player, bool winner, BuildContext context) {
    if (winner == true) {
      //debug purpose
      print('$player has won the game');
      //show alert for a win
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
      //show alert for a draw
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
    //clear the screen
    winner = false;
    p1Tiles = [];
    p2Tiles = [];
    clickedTiles = [];
    tiles = [];
    init();
    notifyListeners();
  }
}
