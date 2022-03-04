import 'dart:async';
import 'package:flutter/material.dart';

class DinoGame extends StatefulWidget {
  @override
  _DinoGameState createState() => _DinoGameState();
}

class _DinoGameState extends State<DinoGame> {
  final ScrollController _scrollController = ScrollController();

  _scrollRight() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 90), curve: Curves.easeOut);
  }

  double dinoYaxis = 1;

  void jump() {
    setState(() {
      dinoYaxis -= 1;
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          dinoYaxis = 1;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _scrollRight());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dino Game'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('Dino Here'),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            children: [
                              ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                itemBuilder: (content, i) {
                                  return Image.asset(
                                    'assets/images/dino1.png',
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 230,
                                width: double.infinity,
                                child: ColoredBox(color: Colors.grey),
                              ),
                            ],
                          ),
                          AnimatedContainer(
                            curve: Curves.easeInOutSine,
                            duration: const Duration(milliseconds: 500),
                            alignment: Alignment(0, dinoYaxis),
                            child: Image.asset(
                              'assets/images/dinoSprite.png',
                              fit: BoxFit.fill,
                              height: 104,
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(onTap: jump, child: Text('Jump')),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
