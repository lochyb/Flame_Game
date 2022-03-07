import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame_practice/components/pauseMenu.dart';
import 'package:flame/sprite.dart';

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
    /// Idle
    final blueWitchIdle = await images.load('B_witch_idle.png'); //
    final blueWitchIdleSprite = SpriteSheet.fromColumnsAndRows(
      image: blueWitchIdle,
      columns: 1,
      rows: 6,
    );
    final spriteIdle = blueWitchIdleSprite.createAnimation(
        from: 0, to: 6, stepTime: 0.2, row: 0, loop: true);

    add(
      SpriteAnimationComponent(
        animation: spriteIdle,
        position: Vector2(100, 100),
        size: Vector2(75, 75),
      ),
    );

    await add(
      PauseButton(
        onPressed: () => overlays.add('pause'),
        sprite: await Sprite.load('pauseButton.png'),
        margin: const EdgeInsets.all(6),
      ),
    );

    /// Run
    final blueWitchRun = await images.load('B_witch_run.png'); //
    final blueWitchRunSprite = SpriteSheet.fromColumnsAndRows(
      image: blueWitchRun,
      columns: 1,
      rows: 8,
    );
    final spriteRun = blueWitchRunSprite.createAnimation(
        from: 0, to: 8, stepTime: 0.2, row: 0, loop: true);
    add(
      SpriteAnimationComponent(
        animation: spriteRun,
        position: Vector2(200, 100),
        size: Vector2(75, 75),
      ),
    );

    /// Death
    final blueWitchDeath = await images.load('B_witch_death.png'); //
    final blueWitchDeathSprite = SpriteSheet(
      image: blueWitchDeath,
      srcSize: Vector2(32, 32),
    );
    final spriteDeath = blueWitchDeathSprite.createAnimation(
        from: 0, to: 12, stepTime: 0.2, row: 0, loop: true);
    add(
      SpriteAnimationComponent(
        animation: spriteDeath,
        position: Vector2(300, 100),
        size: Vector2(75, 75),
      ),
    );

    /// Charge
    final blueWitchCharge = await images.load('B_witch_charge.png'); //
    final blueWitchChargeSprite = SpriteSheet.fromColumnsAndRows(
      image: blueWitchCharge,
      columns: 1,
      rows: 5,
    );
    final spriteCharge = blueWitchChargeSprite.createAnimation(
        from: 0, to: 5, stepTime: 0.2, row: 0, loop: true);
    add(
      SpriteAnimationComponent(
        animation: spriteCharge,
        position: Vector2(400, 100),
        size: Vector2(75, 75),
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
