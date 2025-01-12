import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A custom [ConfettiParticle] that renders an image.
///
/// The [ImageParticle] class extends [ConfettiParticle] to display an image
/// as a particle in a confetti animation. It supports creating particles
/// from both raster image assets and SVG assets, with optional color
/// modifications.
class ImageParticle extends ConfettiParticle {
  /// The image displayed by this particle.
  final Image image;

  /// An optional color overlay applied to the particle.
  ///
  /// If [color] is provided, it will be blended with the image using the
  /// [BlendMode.srcIn] blend mode.
  final Color? color;

  /// Creates an [ImageParticle] with the given [image] and optional [color].
  ///
  /// - [image] is required and represents the particle's visual content.
  /// - [color] can be used to apply a color filter to the particle.
  ImageParticle({required this.image, this.color});

  /// Paints the particle on the provided [canvas] using the given [physics].
  ///
  /// This method renders the image at the position and orientation
  /// determined by the [ConfettiPhysics]. If [color] is set, it applies a
  /// color filter to the image.
  ///
  /// - [physics]: Provides the position, rotation, and other dynamics for
  ///   the particle.
  /// - [canvas]: The canvas on which the particle is painted.
  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  }) {
    canvas.save();

    canvas.translate(physics.x, physics.y);
    canvas.rotate(pi / 10 * physics.wobble);
    canvas.scale(1.0, 1.0);

    final paint = Paint()
      ..color = Color.fromRGBO(255, 255, 255, 1 - physics.progress);

    if (color != null) {
      paint.colorFilter = ColorFilter.mode(color!, BlendMode.srcIn);
    }

    canvas.drawImage(image, Offset.zero, paint);

    canvas.restore();
  }

  /// Creates an [Image] object from a raster image asset.
  ///
  /// This method loads an image from the provided [imageAsset] path and
  /// resizes it to the specified [height] and [width].
  ///
  /// - [imageAsset]: The asset path of the image to be loaded.
  /// - [height]: The target height of the image. Defaults to `50`.
  /// - [width]: The target width of the image. Defaults to `50`.
  ///
  /// Returns a [Future] that completes with the loaded [Image].
  static Future<Image> createUIImageFromImageAsset(
    String imageAsset, {
    int height = 50,
    int width = 50,
  }) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAsset);
    final codec = await instantiateImageCodec(
      assetImageByteData.buffer.asUint8List(),
      targetHeight: height,
      targetWidth: width,
    );

    final frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  /// Creates an [Image] object from an SVG asset.
  ///
  /// This method loads an SVG from the provided [svgAsset] path and converts
  /// it into a raster [Image] of the specified [height] and [width].
  ///
  /// - [svgAsset]: The asset path of the SVG to be loaded.
  /// - [height]: The target height of the image. Defaults to `50`.
  /// - [width]: The target width of the image. Defaults to `50`.
  ///
  /// Returns a [Future] that completes with the rasterized [Image].
  static Future<Image> createUIImageFromSvgAsset(
    String svgAsset, {
    int height = 50,
    int width = 50,
  }) async {
    final PictureInfo pictureInfo =
        await vg.loadPicture(SvgAssetLoader(svgAsset), null);

    final Image image = await pictureInfo.picture.toImage(width, height);

    pictureInfo.picture.dispose();

    return image;
  }
}
