import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../games/ClaseGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<ClaseGame>, KeyboardHandler, HasCollisionDetection {

  int horizontalDirection = 0;
  int verticalDirection = 0;
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 300;
  bool derecha = true;

  bool enElAire = false;
  final double gravedad = 800.0;
  final double alturaSalto = -400.0;

  double posicionInicialY = 0.0;

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center) {
    posicionInicialY = position.y;
  }

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


  void saltar() {
    velocidad.y = alturaSalto;
    enElAire = true;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && !enElAire) {
      saltar();
    }
    //horizontalDirection = 0;
    //verticalDirection = 0;
    // TODO: implement onKeyEvent

      /*if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
          keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        horizontalDirection = -1;
        verticalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
          keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        horizontalDirection = 1;
        verticalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
          keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        horizontalDirection = 1;
        verticalDirection = -1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
          keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        horizontalDirection = -1;
        verticalDirection = -1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        horizontalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        horizontalDirection = -1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        verticalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        verticalDirection = -1;
      }*/

    return true;
  }

  @override
  void update(double dt) {
    velocidad.x = horizontalDirection * aceleracion;
    position += velocidad * dt;

    double screenWidth = gameRef.size.x;

    if (enElAire) {
      velocidad.y += gravedad * dt;
    }


    // Verificar si ha tocado el suelo
    if (position.y >= posicionInicialY) {
      position.y = posicionInicialY;
      enElAire = false;
      velocidad.y = 0;
    }

    if (position.x >= screenWidth - width / 2) {
    derecha = false;
    }

    if (position.x <= width / 2) {
    derecha = true;
    }

    // Cambiar la dirección basada en la variable 'derecha'
    horizontalDirection = derecha ? 1 : -1;
    super.update(dt);
  }

}