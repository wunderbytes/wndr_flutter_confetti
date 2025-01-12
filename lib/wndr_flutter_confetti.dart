library wndr_flutter_confetti;

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:wndr_flutter_confetti/image_particle.dart';

class WunderFlutterConfetti {
  static Future startConfettiWithImageAsset(BuildContext context, String imageAsset, { List<ui.Color>? colors }) {
    return ImageParticle.createUIImageFromImageAsset(imageAsset)
        .then((image) => _startConfettiFromCorners(context: context, image: image, colors: colors));
  }

  static Future startConfettiWithSvgAsset(BuildContext context, String svgAsset, { List<ui.Color>? colors}) {
    return ImageParticle.createUIImageFromSvgAsset(svgAsset)
        .then((image) => _startConfettiFromCorners(context: context, image: image, colors: colors));
  }

  static void _startConfettiFromCorners(
      {required BuildContext context, required ui.Image image, List<ui.Color>? colors}) {
    Confetti.launch(context,
        particleBuilder: (index) => _buildImageParticle(image, colors),
        options: const ConfettiOptions(
            particleCount: 100, spread: 40, startVelocity: 60, y: 1.0, x: 1.0, angle: 110));
    Confetti.launch(context,
        particleBuilder: (index) => _buildImageParticle(image, colors),
        options: const ConfettiOptions(
            particleCount: 100, spread: 40, startVelocity: 60, y: 1.0, x: 0, angle: 70));
  }

  static ImageParticle _buildImageParticle(ui.Image image, List<ui.Color>? colors) =>
      ImageParticle(image: image, color: colors != null ? colors[Random().nextInt(colors.length)] : null);
}
