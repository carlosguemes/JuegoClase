import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../games/ClaseGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<ClaseGame>, KeyboardHandler {

  int horizontalDirection = 0;
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 200;

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    // TODO: implement onKeyEvent
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)){
      horizontalDirection = 1;
    }

    else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
      horizontalDirection = -1;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)){
      position.y+=20;
    }

    else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)){
      position.y-=20;
    }
    return true;
  }

  @override
  void update(double dt) {
    velocidad.x = horizontalDirection * aceleracion;
    position += velocidad * dt;
    super.update(dt);
  }

}