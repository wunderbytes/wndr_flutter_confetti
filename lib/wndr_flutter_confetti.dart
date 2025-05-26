library wndr_flutter_confetti;

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:wndr_flutter_confetti/image_particle.dart';

/// Encapsulates parameters for customizing the confetti animation.
class ConfettiParams {
  final List<ui.Color>? colors;
  final int particleCount;
  final int particleHeight;
  final int particleWidth;
  final double startVelocity;
  final double spread;
  final double angleLeft;
  final double angleRight;

  const ConfettiParams({
    this.colors,
    this.particleCount = 100,
    this.particleHeight = 50,
    this.particleWidth = 50,
    this.startVelocity = 60,
    this.spread = 40,
    this.angleLeft = 70,
    this.angleRight = 110,
  });
}

class WunderFlutterConfetti {
  /// Launches confetti animation using a list of image asset paths (images and/or SVGs).
  static Future startConfettiWithDifferentImages(
      BuildContext context,
      List<String> imageAssets,
      {
        ConfettiParams params = const ConfettiParams()
      }
  ) async {
    final images = await Future.wait(imageAssets.map(
          (asset) => _loadImage(asset, params.particleWidth, params.particleHeight),
    ));

    _startConfettiFromCorners(context: context, images: images, params: params);
  }

  /// Launches confetti animation using a single image asset.
  static Future startConfettiWithImageAsset(
      BuildContext context,
      String imageAsset,
      {
        ConfettiParams params = const ConfettiParams(),
      }
  ) async {
    final image = await ImageParticle.createUIImageFromImageAsset(imageAsset, width: params.particleWidth, height: params.particleHeight);
    _startConfettiFromCorners(context: context, images: [image], params: params);
  }

  /// Launches confetti animation using a single SVG asset.
  static Future startConfettiWithSvgAsset(
      BuildContext context,
      String svgAsset,
      {
        ConfettiParams params = const ConfettiParams(),
      }
  ) async {
    final image = await ImageParticle.createUIImageFromSvgAsset(svgAsset, width: params.particleWidth, height: params.particleHeight);
    _startConfettiFromCorners(context: context, images: [image], params: params);
  }

  /// Private helper to load image or SVG.
  static Future<ui.Image> _loadImage(String asset, int width, int height) {
    final ext = asset.split('.').last.toLowerCase();
    if (['svg'].contains(ext)) {
      return ImageParticle.createUIImageFromSvgAsset(asset, width: width, height: height);
    } else {
      return ImageParticle.createUIImageFromImageAsset(asset, width: width, height: height);
    }
  }

  /// Starts the confetti animation from both screen corners using the provided params.
  static void _startConfettiFromCorners({
    required BuildContext context,
    required List<ui.Image> images,
    required ConfettiParams params,
  }) {
    final random = Random();
    ui.Image randomImage() => images.length > 1 ? images[random.nextInt(images.length)] : images.first;

    buildParticle(int index) => ImageParticle(
      image: randomImage(),
      color: params.colors != null ? params.colors![Random().nextInt(params.colors!.length)] : null
    );

    Confetti.launch(context,
        particleBuilder: buildParticle,
        options: ConfettiOptions(
          particleCount: params.particleCount,
          spread: params.spread,
          startVelocity: params.startVelocity,
          y: 1.0,
          x: 1.0,
          angle: params.angleRight,
        ));

    Confetti.launch(context,
        particleBuilder: buildParticle,
        options: ConfettiOptions(
          particleCount: params.particleCount,
          spread: params.spread,
          startVelocity: params.startVelocity,
          y: 1.0,
          x: 0.0,
          angle: params.angleLeft,
        ));
  }
}