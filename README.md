# Mongol Editor

A comprehensive Flutter package for Mongolian script editing with custom keyboard, ML-powered autocomplete, and rich text editing features.

## Features

- ✨ **Custom Mongolian Keyboard** - Full-featured keyboard for Mongolian script input
- 🤖 **ML-Powered Autocomplete** - PyTorch-based machine learning autocomplete suggestions
- ⌨️ **ZCode Input Method** - Traditional Mongolian input method support
- 🎨 **50+ Mongolian Fonts** - Rich collection of traditional Mongolian fonts
- 📝 **Rich Text Editing** - Full text editing with copy/paste, cursor control
- 🎯 **Word Suggestions** - Context-aware word suggestions
- 💾 **Settings Persistence** - Save user preferences across sessions

## Installation

### Option 1: From Git (Recommended for now)

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  mongol_editor:
    path: ../mongol_editor_package  # or use git url
```

### Option 2: Local Path

```yaml
dependencies:
  mongol_editor:
    path: path/to/mongol_editor_package
```

Then run:
```bash
flutter pub get
```


  🚀 How Anyone Can Use It:

  dependencies:
    mongol_editor:
      git:
        url: https://github.com/zmongol/mongol_editor_package.git

  Then just import:
  import 'package:mongol_editor/mongol_editor.dart';



## Quick Start

### 1. Initialize Controllers

In your `main.dart`:

```dart
import 'package:mongol_editor/mongol_editor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load app settings
  await AppSetting.instance.loadSettings();

  // Initialize GetX controllers
  Get.put(KeyboardController());
  Get.put(TextStyleController());
  Get.put(StyleController());

  runApp(MyApp());
}
```

### 2. Use the Editor

```dart
import 'package:mongol_editor/mongol_editor.dart';

// Open editor for new text
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => EditorPage(editWithImage: false),
  ),
);

// Open editor with existing text
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => EditorPage(
      editWithImage: true,
      text: 'ᠮᠣᠩᠭᠣᠯ',
    ),
  ),
);
```

### 3. Get the edited text

```dart
final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => EditorPage(editWithImage: false),
  ),
);

if (result != null) {
  print('User entered: $result');
}
```

## Configuration

### ML Autocomplete

The package includes ML-powered autocomplete. The model files are included:
- `assets/machine_learning/zmodel.pt` - PyTorch model
- `assets/machine_learning/new_char_to_token.json` - Character mappings

If ML assets are missing, the editor will continue to work with ZCode-based suggestions.

### Fonts

The package includes 50+ traditional Mongolian fonts. Access them via:

```dart
import 'package:mongol_editor/mongol_editor.dart';

TextStyle(
  fontFamily: MongolFonts.z52ordostig,
  // or any other font from MongolFonts class
)
```

## Architecture

```
mongol_editor_package/
├── lib/
│   ├── mongol_editor.dart          # Main export file
│   └── src/
│       ├── editor_page.dart        # Main editor screen
│       ├── controllers/            # GetX controllers
│       ├── keyboard/               # Mongolian keyboard widgets
│       ├── widgets/                # Reusable widgets
│       ├── models/                 # Data models
│       ├── utils/                  # Utilities (ZCode, settings)
│       ├── ml/                     # ML autocomplete
│       ├── components/             # UI components
│       └── constants/              # Constants
├── assets/
│   ├── fonts/                      # Mongolian fonts
│   └── machine_learning/           # ML model files
└── pubspec.yaml
```

## Dependencies

- `mongol` - Mongolian text rendering
- `get` - State management
- `flutter_screenutil` - Responsive UI
- `shared_preferences` - Settings persistence
- `emoji_picker_flutter` - Emoji support
- `pytorch_mobile` - ML inference

## Requirements

- Flutter SDK: ^3.10.3
- Dart SDK: ^3.10.3
- Android: API level 21+
- iOS: iOS 11+

## License

[Your License Here]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Author

[Your Name/Organization]

## Changelog

### 1.0.0
- Initial release
- Full Mongolian keyboard
- ML-powered autocomplete
- 50+ Mongolian fonts
- ZCode input method
