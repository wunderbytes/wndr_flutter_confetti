library wndr_flutter_confetti;

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:wndr_flutter_confetti/image_particle.dart';

/// A Calculator.
class WunderFlutterConfetti {
  static Future startConfettiWithDifferentImages(BuildContext context, List<String> imageAssets,
      {List<ui.Color>? colors, List<String> svgTypes = const ['svg']}) async {
    final images = await Future.wait(imageAssets.map((asset) {
      if (svgTypes.contains(asset.split('.').last)) {
        return ImageParticle.createUIImageFromSvgAsset(asset);
      }

      return ImageParticle.createUIImageFromImageAsset(asset);
    }));

    return _startConfettiFromCorners(context: context, images: images, colors: colors);
  }

  static Future startConfettiWithImageAsset(BuildContext context, String imageAsset, List<ui.Color>? colors) {
    return ImageParticle.createUIImageFromImageAsset(imageAsset)
        .then((image) => _startConfettiFromCorners(context: context, images: [image], colors: colors));
  }

  static Future startConfettiWithSvgAsset(BuildContext context, String svgAsset, List<ui.Color>? colors) {
    return ImageParticle.createUIImageFromSvgAsset(svgAsset)
        .then((image) => _startConfettiFromCorners(context: context, images: [image], colors: colors));
  }

  static void _startConfettiFromCorners(
      {required BuildContext context, required List<ui.Image> images, List<ui.Color>? colors}) {
    randomImage() {
      if (images.length > 1) {
        return images[Random().nextInt(images.length)];
      }

      return images.first;
    }

    Confetti.launch(context,
        particleBuilder: (index) => _buildImageParticle(randomImage(), colors),
        options: const ConfettiOptions(
            particleCount: 100, spread: 40, startVelocity: 60, y: 1.0, x: 1.0, angle: 110));
    Confetti.launch(context,
        particleBuilder: (index) => _buildImageParticle(randomImage(), colors),
        options: const ConfettiOptions(
            particleCount: 100, spread: 40, startVelocity: 60, y: 1.0, x: 0, angle: 70));
  }

  static ImageParticle _buildImageParticle(ui.Image image, List<ui.Color>? colors) =>
      ImageParticle(image: image, color: colors?[Random().nextInt(colors.length)]);
}
