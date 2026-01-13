# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-12-09

### Added
- Initial release of Mongol Editor package
- Custom Mongolian keyboard with full character support
- ML-powered autocomplete using PyTorch Mobile
- ZCode input method for traditional Mongolian typing
- 50+ traditional Mongolian fonts included
- Rich text editing with copy/paste functionality
- Cursor control (move up/down)
- Word suggestion system with ML and ZCode integration
- Settings persistence using SharedPreferences
- Emoji picker support
- Delete confirmation dialog
- Vertical text display using Mongol package
- Custom tooltips for Mongolian text
- Screen-responsive UI using flutter_screenutil
- GetX state management for controllers

### Features
- **EditorPage**: Main editor screen with full editing capabilities
- **KeyboardController**: Manages keyboard input and text editing
- **TextStyleController**: Controls text styling and formatting
- **StyleController**: Manages overall style settings
- **MongolKeyboard**: Custom keyboard widget with Mongol/English/Symbol layouts
- **WordSuggestionsSection**: Displays autocomplete suggestions
- **AppSetting**: Persistent settings management
- **MongolMLAutocomplete**: AI-powered word completion

### Included Assets
- 50+ Mongolian font families
- PyTorch ML model (zmodel.pt)
- Character-to-token mappings for ML

### Dependencies
- mongol: ^9.0.0
- get: ^4.6.6
- flutter_screenutil: ^5.9.3
- shared_preferences: ^2.5.3
- emoji_picker_flutter: ^4.4.0
- pytorch_mobile (from Git)

## [Unreleased]

### Planned
- Additional keyboard layouts
- More ML model optimizations
- Custom theme support
- Export to different formats
- Cloud sync support
