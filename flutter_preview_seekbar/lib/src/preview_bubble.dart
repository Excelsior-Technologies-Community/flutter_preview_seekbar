import 'package:flutter/material.dart';
import 'utils.dart';

class PreviewBubble extends StatelessWidget {
  final double position;
  final Duration duration;
  final Widget? child;

  const PreviewBubble({
    super.key,
    required this.position,
    required this.duration,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final time =
        duration * position;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black26,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (child != null) child!,
            const SizedBox(height: 4),
            Text(
              formatDuration(time),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
