import 'package:flutter/material.dart';
import 'package:wndr_flutter_confetti/wndr_flutter_confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confetti Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Confetti Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                WunderFlutterConfetti.startConfettiWithSvgAsset(
                    context, 'assets/ufo_face.svg', colors: [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.yellow
                ]);
              },
              child: const Text(
                'Confetti with SVG',
              ),
            ),
            TextButton(
              onPressed: () {
                WunderFlutterConfetti.startConfettiWithImageAsset(
                    context, 'assets/ufo_face.png', colors: [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.yellow
                ]);
              },
              child: const Text(
                'Confetti with PNG',
              ),
            ),
            TextButton(
              onPressed: () {
                WunderFlutterConfetti.startConfettiWithDifferentImages(context, [
                  /*'assets/ufo_face.png',
                  'assets/ufo_face.svg',*/
                  'assets/ufo_saucer.svg',
                ], colors: [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.yellow
                ]);
              },
              child: const Text(
                'Confetti with PNGs and SVGs',
              ),
            )
          ],
        ),
      ),
    );
  }
}
