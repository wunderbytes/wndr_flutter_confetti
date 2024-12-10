import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageParticle extends ConfettiParticle {
  static Future<Image> createUIImageFromImageAsset(String imageAsset,
      {int height = 50, int width = 50}) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAsset);
    final codec = await instantiateImageCodec(
      assetImageByteData.buffer.asUint8List(),
      targetHeight: height,
      targetWidth: width,
    );

    final frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  static Future<Image> createUIImageFromSvgAsset(String svgAsset, {int height = 50, int width = 50}) async {
    final PictureInfo pictureInfo = await vg.loadPicture(SvgAssetLoader(svgAsset), null);

    final Image image = await pictureInfo.picture.toImage(width, height);

    pictureInfo.picture.dispose();

    return image;
  }

  final Image image;
  final Color? color;

  ImageParticle({required this.image, this.color});

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
}
