String formatDuration(Duration d) {
  String two(int n) => n.toString().padLeft(2, '0');

  final h = d.inHours;
  final m = two(d.inMinutes.remainder(60));
  final s = two(d.inSeconds.remainder(60));

  if (h > 0) {
    return "$h:$m:$s";
  }
  return "$m:$s";
}