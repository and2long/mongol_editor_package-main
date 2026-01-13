
class CustomizableText {
  int? id;
  int? imageId;
  String tag;
  String text;
  bool editable;
  String? copyFromTag;
  double dx;
  double dy;
  int isHistoryItem;

  // Video timestamp support (in seconds)
  double? startTime; // When text should appear (null = always show)
  double? endTime;   // When text should disappear (null = show until end)

  // Text styling properties
  int? textColor;    // Color as int (0xAARRGGBB)
  double? fontSize;  // Font size
  String? fontFamily; // Font family name
  bool? hasShadow;   // Whether text has shadow
  bool? hasBackground; // Whether text has background

  CustomizableText({
    this.id,
    this.imageId,
    required this.tag,
    required this.text,
    required this.editable,
    this.copyFromTag,
    this.dx = 16.0,
    this.dy = 16.0,
    this.isHistoryItem = 0,
    this.startTime,
    this.endTime,
    this.textColor,
    this.fontSize,
    this.fontFamily,
    this.hasShadow = false,
    this.hasBackground = false,
  });

  setImageId(int imageId) {
    this.imageId = imageId;
  }

  setId(int id) {
    this.id = id;
  }

  /// Check if text should be visible at given time (in seconds)
  bool isVisibleAtTime(double currentTime) {
    // If no timestamps set, always visible
    if (startTime == null && endTime == null) {
      return true;
    }

    // Check if within time range
    final afterStart = startTime == null || currentTime >= startTime!;
    final beforeEnd = endTime == null || currentTime <= endTime!;

    return afterStart && beforeEnd;
  }

  /// Get display string for time range
  String getTimeRangeString() {
    if (startTime == null && endTime == null) {
      return 'Always visible';
    }

    String formatTime(double seconds) {
      int minutes = seconds ~/ 60;
      int secs = (seconds % 60).toInt();
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }

    final start = startTime != null ? formatTime(startTime!) : '00:00';
    final end = endTime != null ? formatTime(endTime!) : 'End';

    return '$start - $end';
  }

  Map<String, dynamic> toMap() {
    return {
      'imageId': imageId,
      'text': text,
      'dx': dx,
      'dy': dy,
      'startTime': startTime,
      'endTime': endTime,
      'textColor': textColor,
      'fontSize': fontSize,
      'fontFamily': fontFamily,
      'hasShadow': hasShadow,
      'hasBackground': hasBackground,
    };
  }

  @override
  String toString() {
    return 'CustomizableText{id: $id, imageId: $imageId, tag: $tag, text: $text, dx: $dx, dy: $dy, startTime: $startTime, endTime: $endTime, color: $textColor, size: $fontSize, font: $fontFamily, isHistoryItem: $isHistoryItem}';
  }
}