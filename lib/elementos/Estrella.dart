import 'package:flame/components.dart';

import '../games/ClaseGame.dart';

class Estrella extends SpriteComponent with HasGameRef<ClaseGame>{

  Estrella({required super.position, required super.size});

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('star.png'));
    anchor = Anchor.center;
    return super.onLoad();
  }

}