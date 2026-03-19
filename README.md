## 🎯 flutter_preview_seekbar
```
flutter_preview_seekbar is a reusable Flutter video/audio seek bar library that provides a smooth custom progress bar with animated thumb, buffered progress indicator and floating preview bubble.

It helps developers easily integrate advanced media seeking UI without writing complex gesture handling, custom painter logic or animation code.

You can use it with any video player or audio player to create modern streaming UI experience.
```

---

## ✨ Feature Preview
```
- 🎬 YouTube style draggable seekbar
- 🫧 Floating preview bubble with time label
- 📊 Buffered progress indicator
- 🎯 Tap to seek support
- ✋ Smooth horizontal drag gesture
- 🔴 Animated thumb scaling effect
- 🎨 Fully customizable colors & sizes
- ⏱ Duration formatter utility
- 🧱 Clean architecture (Painter + Widgets + Utils)
- 📦 Lightweight and reusable
- 🌐 Works on Android, iOS, Web & Desktop
```

---

## 📦 Installation

Add dependency in your pubspec.yaml.
```
dependencies:
flutter_preview_seekbar:
path: ../flutter_preview_seekbar
```
Then run:
```
flutter pub get
```

---

## 🎬 Preview

https://github.com/user-attachments/assets/19ccb9cc-5bed-4266-b561-3c5a67da7f90

---

## 🗂 File Structure
```
flutter_preview_seekbar/
│
├─ lib/
│ ├─ flutter_preview_seekbar.dart
│ │ // Main export file
│ │
│ ├─ src/
│ │ ├─ preview_seekbar.dart
│ │ │ // Main custom seekbar widget
│ │ │
│ │ ├─ preview_painter.dart
│ │ │ // Draws played / buffered / background track
│ │ │
│ │ ├─ preview_bubble.dart
│ │ │ // Floating preview UI with time label
│ │ │
│ │ └─ utils.dart
│ │ // Duration formatting helper
│ │
│ └─ main.dart
│ // Demo app using the seekbar with video player
│ 
│
├─ README.md
│
├─ LICENSE
│
└─ pubspec.yaml
```


---

## 🚀 How To Use

### 1️⃣ Import package
```
import 'package:flutter_preview_seekbar/flutter_preview_seekbar.dart';
```


---

### 2️⃣ Add Seekbar
```
PreviewSeekbar(
value: progress,
buffer: bufferValue,
duration: videoDuration,
previewChild: Image.network(thumbnailUrl),
onChanged: (v) {
seekVideo(v);
},
)
```

---

## 🎬 Full Example (With Video Player)
```
PreviewSeekbar(
value: progress,
buffer: controller.value.buffered.isNotEmpty
? controller.value.buffered.last.end.inMilliseconds /
controller.value.duration.inMilliseconds
: 0,
duration: controller.value.duration,
previewChild: Container(
width: 120,
height: 60,
color: Colors.black,
alignment: Alignment.center,
child: Text(
"Preview",
style: TextStyle(color: Colors.white),
),
),
onChanged: (v) {
final newPosition = controller.value.duration * v;
controller.seekTo(newPosition);
},
)
```


---

## ⚙️ Seekbar Properties

| Property        | Type                  | Description |
|----------------|----------------------|------------|
| value          | double               | Current progress value (0 → 1) |
| buffer         | double               | Buffered progress value |
| duration       | Duration             | Total media duration |
| onChanged      | Function(double)     | Seek callback |
| previewChild   | Widget               | Custom preview widget |
| playedColor    | Color                | Played track color |
| bufferedColor  | Color                | Buffered track color |
| backgroundColor| Color                | Background track color |
| height         | double               | Seekbar height |
| trackHeight    | double               | Track thickness |
| thumbRadius    | double               | Thumb size |

---

## 🧠 Use Cases
```
- 🎥 Video streaming apps
- 🎧 Audio player apps
- 📚 Course / tutorial apps
- 📺 OTT platform UI
- 🎮 Media timeline UI
```

---

## 📄 MIT License
```
Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files to deal in the Software
without restriction.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
```
