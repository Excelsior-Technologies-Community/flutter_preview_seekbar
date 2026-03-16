import 'package:flutter/material.dart';
import 'preview_painter.dart';
import 'preview_bubble.dart';

class PreviewSeekbar extends StatefulWidget {
  final double value;
  final double buffer;
  final Duration duration;
  final ValueChanged<double> onChanged;
  final Widget? previewChild;

  final Color playedColor;
  final Color bufferedColor;
  final Color backgroundColor;

  final double height;
  final double trackHeight;
  final double thumbRadius;

  const PreviewSeekbar({
    super.key,
    required this.value,
    required this.duration,
    required this.onChanged,
    this.buffer = 0,
    this.previewChild,
    this.playedColor = Colors.red,
    this.bufferedColor = Colors.white54,
    this.backgroundColor = Colors.white24,
    this.height = 50,
    this.trackHeight = 4,
    this.thumbRadius = 7,
  });

  @override
  State<PreviewSeekbar> createState() => _PreviewSeekbarState();
}

class _PreviewSeekbarState extends State<PreviewSeekbar>
    with SingleTickerProviderStateMixin {
  double localValue = 0;
  bool dragging = false;

  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    localValue = widget.value;

    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    scale = Tween(begin: 1.0, end: 1.5).animate(controller);
  }

  void updatePosition(Offset pos, double width) {
    double v = pos.dx / width;
    v = v.clamp(0.0, 1.0);

    setState(() {
      localValue = v;
    });

    widget.onChanged(v);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, con) {
        return GestureDetector(
          onHorizontalDragStart: (d) {
            dragging = true;
            controller.forward();
            updatePosition(d.localPosition, con.maxWidth);
          },
          onHorizontalDragUpdate: (d) {
            updatePosition(d.localPosition, con.maxWidth);
          },
          onHorizontalDragEnd: (_) {
            dragging = false;
            controller.reverse();
          },
          onTapDown: (d) {
            updatePosition(d.localPosition, con.maxWidth);
          },
          child: SizedBox(
            height: widget.height,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                CustomPaint(
                  size: Size(con.maxWidth, widget.height),
                  painter: PreviewPainter(
                    value: dragging ? localValue : widget.value,
                    buffer: widget.buffer,
                    playedColor: widget.playedColor,
                    bufferedColor: widget.bufferedColor,
                    backgroundColor: widget.backgroundColor,
                    trackHeight: widget.trackHeight,
                  ),
                ),

                /// Thumb
                AnimatedBuilder(
                  animation: scale,
                  builder: (context, child) {
                    return Positioned(
                      left: (dragging ? localValue : widget.value) *
                          con.maxWidth -
                          widget.thumbRadius,
                      child: Transform.scale(
                        scale: scale.value,
                        child: Container(
                          width: widget.thumbRadius * 2,
                          height: widget.thumbRadius * 2,
                          decoration: BoxDecoration(
                            color: widget.playedColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                /// Floating Preview
                if (dragging)
                  Positioned(
                    left: localValue * con.maxWidth - 40,
                    bottom: 30,
                    child: PreviewBubble(
                      position: localValue,
                      duration: widget.duration,
                      child: widget.previewChild,
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}