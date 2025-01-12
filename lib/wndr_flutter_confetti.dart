/// A library for creating confetti animations with custom images.
///
/// The `wndr_flutter_confetti` library provides functionality to create
/// and launch confetti animations using custom image or SVG assets.
/// It integrates with the [flutter_confetti] package and utilizes the
/// [ImageParticle] class to render confetti particles.
library wndr_flutter_confetti;

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:wndr_flutter_confetti/image_particle.dart';

/// A utility class to launch confetti animations with custom images or SVGs.
///
/// The [WunderFlutterConfetti] class provides static methods for starting
/// confetti animations with image or SVG assets. Confetti particles can be
/// customized with optional color overlays, and animations are launched from
/// the corners of the screen.
class WunderFlutterConfetti {
  /// Launches a confetti animation using an image asset.
  ///
  /// This method loads an image from the provided [imageAsset] path, creates
  /// confetti particles using the [ImageParticle] class, and launches the
  /// animation from the corners of the screen.
  ///
  /// - [context]: The [BuildContext] used to render the confetti.
  /// - [imageAsset]: The asset path of the image to use for confetti particles.
  /// - [colors]: An optional list of [ui.Color] values to apply as overlays to
  ///   the particles.
  ///
  /// Returns a [Future] that completes when the confetti animation is launched.
  static Future startConfettiWithImageAsset(
    BuildContext context,
    String imageAsset, {
    List<ui.Color>? colors,
  }) {
    return ImageParticle.createUIImageFromImageAsset(imageAsset).then((image) =>
        _startConfettiFromCorners(
            context: context, image: image, colors: colors));
  }

  /// Launches a confetti animation using an SVG asset.
  ///
  /// This method loads an SVG from the provided [svgAsset] path, converts it
  /// into a raster image, creates confetti particles using the [ImageParticle]
  /// class, and launches the animation from the corners of the screen.
  ///
  /// - [context]: The [BuildContext] used to render the confetti.
  /// - [svgAsset]: The asset path of the SVG to use for confetti particles.
  /// - [colors]: An optional list of [ui.Color] values to apply as overlays to
  ///   the particles.
  ///
  /// Returns a [Future] that completes when the confetti animation is launched.
  static Future startConfettiWithSvgAsset(
    BuildContext context,
    String svgAsset, {
    List<ui.Color>? colors,
  }) {
    return ImageParticle.createUIImageFromSvgAsset(svgAsset).then((image) =>
        _startConfettiFromCorners(
            context: context, image: image, colors: colors));
  }

  /// Starts a confetti animation from the corners of the screen.
  ///
  /// This private method launches two sets of confetti animations: one from
  /// the top-right corner and one from the top-left corner. Each particle is
  /// rendered using an [ImageParticle], with optional color overlays.
  ///
  /// - [context]: The [BuildContext] used to render the confetti.
  /// - [image]: The image used for confetti particles.
  /// - [colors]: An optional list of [ui.Color] values to apply as overlays to
  ///   the particles.
  static void _startConfettiFromCorners({
    required BuildContext context,
    required ui.Image image,
    List<ui.Color>? colors,
  }) {
    Confetti.launch(context,
        particleBuilder: (index) => _buildImageParticle(image, colors),
        options: const ConfettiOptions(
            particleCount: 100,
            spread: 40,
            startVelocity: 60,
            y: 1.0,
            x: 1.0,
            angle: 110));
    Confetti.launch(context,
        particleBuilder: (index) => _buildImageParticle(image, colors),
        options: const ConfettiOptions(
            particleCount: 100,
            spread: 40,
            startVelocity: 60,
            y: 1.0,
            x: 0,
            angle: 70));
  }

  /// Builds an [ImageParticle] for use in the confetti animation.
  ///
  /// This private method creates an [ImageParticle] using the given [image].
  /// If [colors] is provided, a random color from the list is applied as an
  /// overlay to the particle.
  ///
  /// - [image]: The image used for the particle.
  /// - [colors]: An optional list of [ui.Color] values to apply as overlays to
  ///   the particle.
  ///
  /// Returns the created [ImageParticle].
  static ImageParticle _buildImageParticle(
          ui.Image image, List<ui.Color>? colors) =>
      ImageParticle(
          image: image,
          color:
              colors != null ? colors[Random().nextInt(colors.length)] : null);
}
