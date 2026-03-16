import 'package:flutter/material.dart';

class PreviewPainter extends CustomPainter {
  final double value;
  final double buffer;
  final Color playedColor;
  final Color bufferedColor;
  final Color backgroundColor;
  final double trackHeight;

  PreviewPainter({
    required this.value,
    required this.buffer,
    required this.playedColor,
    required this.bufferedColor,
    required this.backgroundColor,
    required this.trackHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.height / 2;

    final bg = Paint()
      ..color = backgroundColor
      ..strokeWidth = trackHeight
      ..strokeCap = StrokeCap.round;

    final bufferPaint = Paint()
      ..color = bufferedColor
      ..strokeWidth = trackHeight
      ..strokeCap = StrokeCap.round;

    final played = Paint()
      ..color = playedColor
      ..strokeWidth = trackHeight
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(0, center), Offset(size.width, center), bg);

    canvas.drawLine(
        Offset(0, center),
        Offset(size.width * buffer, center),
        bufferPaint);

    canvas.drawLine(
        Offset(0, center),
        Offset(size.width * value, center),
        played);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}