import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

///
class SideScrollComponent extends PositionComponent
    with HasHitboxes, Collidable {
  /// Create a new Rocket component at the given [position].
  SideScrollComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  final shape = HitboxPolygon([
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0),
  ]);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addHitbox(shape);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Temporary render item
    renderHitboxes(canvas, paint: Paint()..color = Colors.pink);
  }
}
