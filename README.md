# Wndr Confetti Package

A Flutter package that simplifies showing confetti animations from the bottom corners of the screen.

## Features

- Easy integration of confetti animations
- Customizable confetti images from assets with custom colors

## Usage

### 1. Import the Package
```dart
import 'package:wndr_flutter_confetti/wndr_flutter_confetti.dart';
```

### 2. Show Confetti animation

There are two methods you can use to show confetti. The first parameter is BuildContext, the second is the asset path of
your image, and the last is an optional list of colors used randomly as a ColorFilter on confetti particles.

```dart
// Use this for image assets like png, jpg, etc.
WunderFlutterConfetti.startConfettiWithImageAsset(
    context,
    'assets/ufo.png',
    params: const ConfettiParams(
      [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.yellow]
    )
);
```

```dart
// Use this for vector graphic assets
WunderFlutterConfetti.startConfettiWithSvgAsset(
    context,
    'assets/ufo.svg',
    params: const ConfettiParams(
      colors: [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.yellow]
    )
);
```

_```dart
// Use this for vector graphic and image assets
WunderFlutterConfetti.startConfettiWithDifferentImages(context, [
  'assets/ufo.png',
  'assets/ufo.svg',
  ],
  params: const ConfettiParams(
    colors: [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.yellow],
  )
);
```_



