import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_game/utils/socket_client.dart';

import '../provider/game_state_provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  // create game
  createGame(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('create-game', {
        'nickname': nickname,
      });
    }
  }


    // join game
  joinGame(String gameId, String nickname) {
    if (nickname.isNotEmpty && gameId.isNotEmpty) {
      _socketClient.emit('join-game', {
        'nickname': nickname,
        'gameId': gameId,
      });
    }
  }


//listen to update game
  updateGameListener(BuildContext context) {
    _socketClient.on('updateGame', (data) {
      final gameStateListener =
          Provider.of<GameStateProvider>(context, listen: false)
              .updateGameState(
                  id: data['_id'],
                  players: data['players'],
                  isJoin: data['isJoin'],
                  isOver: data['isOver'],
                  words: data['words']);
      if (data['_id'].isNotEmpty) {
        Navigator.pushNamed(context, '/game-screen');
      }
    });
  }
}
