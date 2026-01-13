/// Mongolian Script Editor Package
///
/// A comprehensive package for Mongolian script editing with:
/// - Custom Mongolian keyboard
/// - ML-powered autocomplete
/// - Rich text editing
/// - Multiple Mongolian fonts
library mongol_editor;

// Export the main editor screen
export 'src/editor_page.dart';

// Export controllers
export 'src/controllers/keyboard_controller.dart';
export 'src/controllers/text_controller.dart';
export 'src/controllers/style_controller.dart';

// Export models
export 'src/models/customizable_text.dart';

// Export components
export 'src/components/mongol_tooltip.dart';
export 'src/components/mongol_fonts.dart';

// Export utilities
export 'src/utils/app_setting.dart';
export 'src/utils/zcode_logic.dart';

// Export widgets (optional - users can choose to use these)
export 'src/widgets/word_suggestions_section.dart';
export 'src/widgets/delete_confirmation_dialog.dart';

// Export constants
export 'src/constants/dialog_styles.dart';
