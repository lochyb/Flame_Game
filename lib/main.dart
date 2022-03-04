import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_practice/components/SideScroll.dart';
import 'package:flutter/material.dart';
import 'package:flame_practice/pauseMenu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();

  final game = MoonlanderGame();

  runApp(
    MaterialApp(
      home: GameWidget(
        game: game,
        //Work in progress loading screen on game start
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        //Work in progress error handling
        errorBuilder: (context, ex) {
          //Print the error in th dev console
          debugPrint(ex.toString());
          return const Center(
            child: Text('Sorry, something went wrong. Reload me'),
          );
        },
        overlayBuilderMap: {
          'pause': (context, MoonlanderGame game) => PauseMenu(game: game),
        },
      ),
    ),
  );
}

/// This class encapulates the whole game.
class MoonlanderGame extends FlameGame with HasCollidables {
  @override
  Future<void> onLoad() async {
    unawaited(
        add(SideScrollComponent(position: size / 2, size: Vector2.all(20))));

    return super.onLoad();
  }
}
