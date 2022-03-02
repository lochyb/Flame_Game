import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        canvasColor: Colors.grey[400],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstRoute(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Playground'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Dino Route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DinoGame()),
            );
          },
        ),
      ),
    );
  }
}

class DinoGame extends StatefulWidget {
  @override
  _DinoGameState createState() => _DinoGameState();
}

class _DinoGameState extends State<DinoGame> {
  ScrollController _scrollController = ScrollController();

  _scrollRight() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 90), curve: Curves.easeOut);
  }

  double dinoYaxis = 1;

  void jump() {
    setState(() {
      dinoYaxis -= 1;
      Timer(Duration(milliseconds: 500), () {
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
                              SizedBox(
                                height: 230,
                                width: double.infinity,
                                child: ColoredBox(color: Colors.grey),
                              ),
                            ],
                          ),
                          AnimatedContainer(
                            curve: Curves.easeInOutSine,
                            duration: Duration(milliseconds: 500),
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
