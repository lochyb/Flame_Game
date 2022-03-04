import 'package:flutter/material.dart';
import 'main.dart';

class PauseMenu extends StatelessWidget {
  ///
  const PauseMenu({Key? key, required this.game}) : super(key: key);

  /// The reference to the game.
  final MoonlanderGame game;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Center(
                  child: Text(
                    'Pause',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => game.overlays.remove('pause'),
                  child: const Text('Resume'),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('pause');
                    game.overlays.add('levels');
                  },
                  child: const Text('Levels'),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                  onPressed: () => game.overlays.remove('pause'),
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
