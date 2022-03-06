import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame_practice/components/pauseMenu.dart';

class Dino extends SpriteComponent {
  Dino() : super(size: Vector2.all(32));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('dinoSprite.png');
    anchor = Anchor.center;
    await super.onLoad();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }
}

class PauseButton extends HudButtonComponent {
  PauseButton({
    required EdgeInsets margin,
    required Sprite sprite,
    required VoidCallback onPressed,
    Sprite? spritePressed,
  }) : super(
          button: SpriteComponent(
            position: Vector2.zero(),
            sprite: sprite,
            size: Vector2(50, 25),
          ),
          margin: margin,
          onPressed: onPressed,
        );
}

class CubeJump extends FlameGame
    with
        HasCollidables,
        HasTappables,
        HasKeyboardHandlerComponents,
        HasDraggables {
  void onOverlayChanged() {
    if (overlays.isActive('pause')) {
      pauseEngine();
    } else {
      resumeEngine();
    }
  }

  @override
  bool get debugMode => kDebugMode;

  /// Restart the current level.
  void restart() {
    // TODO: Implement restart of current level.
  }

  @override
  void onMount() {
    overlays.addListener(onOverlayChanged);
    super.onMount();
  }

  @override
  void onRemove() {
    overlays.removeListener(onOverlayChanged);
    super.onRemove();
  }

  @override
  Future<void> onLoad() async {
    add(Dino());
    await add(
      PauseButton(
        onPressed: () => overlays.add('pause'),
        sprite: await Sprite.load('pauseButton.png'),
        margin: const EdgeInsets.all(6),
      ),
    );
    await super.onLoad();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();

  final game = CubeJump();

  runApp(
    MaterialApp(
      home: GameWidget(
        game: game,
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorBuilder: (context, ex) {
          debugPrint(ex.toString());
          return const Center(
            child: Text('Sorry, something went wrong. Reload me'),
          );
        },
        overlayBuilderMap: {
          'pause': (context, CubeJump game) => PauseMenu(game: game),
        },
      ),
    ),
  );
}
